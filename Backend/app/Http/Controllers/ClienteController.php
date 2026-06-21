<?php

namespace App\Http\Controllers;

use App\Models\Cliente;
use App\Services\BonsaeIntegrationService;
use Illuminate\Http\Request;

class ClienteController extends Controller
{
    public function index(Request $request)
    {
        return response()->json(
            Cliente::where('user_id', $request->user()->id)->latest()->get()
        );
    }

    public function show(Request $request, $id)
    {
        $cliente = Cliente::where('user_id', $request->user()->id)->find($id);

        if (!$cliente) {
            return response()->json(['message' => 'Cliente nao encontrado'], 404);
        }

        return response()->json($cliente);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'cpf' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
            'telephone' => 'nullable|string|max:30',
            'descrition' => 'nullable|string|max:255',
            'naturalness' => 'nullable|string|max:255',
        ]);

        $cliente = Cliente::create([
            ...$data,
            'user_id' => $request->user()->id,
        ]);

        return response()->json($cliente, 201);
    }

    public function update(Request $request, $id)
    {
        $cliente = Cliente::where('user_id', $request->user()->id)->find($id);

        if (!$cliente) {
            return response()->json(['message' => 'Cliente nao encontrado'], 404);
        }

        $data = $request->validate([
            'nome' => 'sometimes|required|string|max:255',
            'cpf' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
            'telefone' => 'nullable|string|max:30',
            'endereco' => 'nullable|string|max:255',
            'cidade' => 'nullable|string|max:255',
            'estado' => 'nullable|string|max:2',
            'cep' => 'nullable|string|max:20',
        ]);

        $cliente->update($data);

        return response()->json($cliente);
    }

    public function destroy(Request $request, $id)
    {
        $cliente = Cliente::where('user_id', $request->user()->id)->find($id);

        if (!$cliente) {
            return response()->json(['message' => 'Cliente nao encontrado'], 404);
        }

        $cliente->delete();

        return response()->json(['message' => 'Cliente deletado com sucesso']);
    }

    public function importarDaBonsae(Request $request)
    {
        $service = new BonsaeIntegrationService();
        $service->importarClientes($request->user());

        return response()->json(['message' => 'Clientes importados com sucesso!']);
    }

    public function clientesBonsae(Request $request)
    {
        $user = $request->user();

        if (!$user->bonsae_user_id) {
            return response()->json([]);
        }

        $clientes = \App\Models\Bonsae\BonsaeClient::with('address')
            ->where('creator_id', $user->bonsae_user_id)
            ->whereNull('deleted_at')
            ->get()
            ->map(function ($c) {
                $address = $c->address;
                return [
                    'id'             => $c->id,
                    'nome'           => $c->name,
                    'nome_social'    => $c->social_name,
                    'tipo_pessoa'    => $c->kind_of_person,
                    'cpf'            => $c->cpf,
                    'cnpj'           => $c->cnpj,
                    'rg'             => $c->rg,
                    'orgao_emissor'  => $c->issuing_body,
                    'uf_emissor'     => $c->uf_issuing_body,
                    'data_nascimento'=> $c->birth_date,
                    'nacionalidade'  => $c->nationality,
                    'naturalidade'   => $c->naturalness,
                    'estado_civil'   => $c->marital_status,
                    'profissao'      => $c->profession,
                    'escolaridade'   => $c->education,
                    'renda_mensal'   => $c->monthly_income,
                    'nome_mae'       => $c->mother_name,
                    'nome_pai'       => $c->father_name,
                    'titulo_eleitor' => $c->voter_registration,
                    'pis'            => $c->pis,
                    'telefone'       => $c->telephone,
                    'telefone2'      => $c->telephone2,
                    'email'          => $c->email,
                    'endereco'       => $address?->street_name,
                    'numero'         => $address?->number,
                    'complemento'    => $address?->complement,
                    'bairro'         => $address?->neighborhood,
                    'cidade'         => $address?->city?->name ?? null,
                    'estado'         => $address?->state?->uf ?? null,
                    'cep'            => $address?->cep,
                    'created_at'     => $c->created_at,
                    'updated_at'     => $c->updated_at,
                ];
            });

        return response()->json($clientes);
    }
}