<?php

namespace App\Services;

use App\Models\User;
use App\Models\Bonsae\BonsaeUser;
use App\Models\Bonsae\BonsaeClient;
use App\Models\Cliente;
use Illuminate\Support\Facades\Hash;

class BonsaeIntegrationService
{
    /**
     * Encontra (ou cria) o usuário local a partir do e-mail da Bonsae.
     * Retorna null se o e-mail não existir na Bonsae.
     */
    public function sincronizarUsuario(string $email): ?User
    {
        // 1. Busca o usuário na Bonsae
        $bonsaeUser = BonsaeUser::findByEmail($email);

        if (!$bonsaeUser) {
            return null; // Usuário não existe na Bonsae
        }

        // 2. Verifica se já existe um usuário local vinculado a este ID da Bonsae
        $userLocal = User::where('bonsae_user_id', $bonsaeUser->id)->first();

        if ($userLocal) {
            // Atualiza nome caso tenha mudado na Bonsae
            $userLocal->update(['name' => $bonsaeUser->name]);
            return $userLocal;
        }

        // 3. Cria o usuário local vinculado à Bonsae
        $userLocal = User::create([
            'name'           => $bonsaeUser->name,
            'email'          => $bonsaeUser->email,
            'password'       => $bonsaeUser->password, // senha já é hash
            'bonsae_user_id' => $bonsaeUser->id,
        ]);

        return $userLocal;
    }

    /**
     * Importa os clientes da Bonsae para o seu banco,
     * vinculando ao usuário local correspondente.
     */
    public function importarClientes(User $userLocal): void
    {
        if (!$userLocal->bonsae_user_id) {
            return; // Usuário não tem vínculo com a Bonsae
        }

        $clientesBonsae = BonsaeClient::findByCreator($userLocal->bonsae_user_id);

        foreach ($clientesBonsae as $clienteBonsae) {
            // Evita duplicar: verifica pelo CPF ou nome
            $jaExiste = Cliente::where('user_id', $userLocal->id)
                ->where(function ($q) use ($clienteBonsae) {
                    $q->where('cpf', $clienteBonsae->cpf)
                      ->orWhere('nome', $clienteBonsae->name);
                })->exists();

            if (!$jaExiste) {
                Cliente::create([
                    'user_id'  => $userLocal->id,
                    'nome'     => $clienteBonsae->name,
                    'cpf'      => $clienteBonsae->cpf,
                    'email'    => $clienteBonsae->email,
                    'telefone' => $clienteBonsae->telephone,
                ]);
            }
        }
    }

    /**
     * Retorna os clientes da Bonsae de um usuário (sem importar).
     * Útil para mostrar na tela para o usuário escolher.
     */
    public function listarClientesBonsae(User $userLocal): \Illuminate\Support\Collection
    {
        if (!$userLocal->bonsae_user_id) {
            return collect([]);
        }

        return BonsaeClient::findByCreator($userLocal->bonsae_user_id);
    }
}