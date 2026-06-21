<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Services\BonsaeIntegrationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'password' => 'required|string|min:6',
        ]);

        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
        ]);

        return response()->json($this->tokenResponse($user), 201);
    }

    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        // 1. Tenta logar normalmente no seu banco
        $user = User::where('email', $data['email'])->first();

        if ($user && Hash::check($data['password'], $user->password)) {
            return response()->json($this->tokenResponse($user));
        }

        // 2. Se não encontrou, tenta sincronizar com a Bonsae
        $bonsaeService = new BonsaeIntegrationService();
        $user = $bonsaeService->sincronizarUsuario($data['email']);

        if ($user && Hash::check($data['password'], $user->password)) {
            return response()->json($this->tokenResponse($user));
        }

        // 3. Se não achou em nenhum dos dois, retorna erro
        throw ValidationException::withMessages([
            'email' => ['Credenciais invalidas.'],
        ]);
    }

    public function me(Request $request)
    {
        return response()->json($request->user());
    }

    public function logout(Request $request)
    {
        $request->user()?->currentAccessToken()?->delete();

        return response()->json([
            'message' => 'Logout realizado com sucesso.',
        ]);
    }

    private function tokenResponse(User $user)
    {
        return [
            'user' => $user,
            'token' => $user->createToken('bonsae-front')->plainTextToken,
            'token_type' => 'Bearer',
        ];
    }
}