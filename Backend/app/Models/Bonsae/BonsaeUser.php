<?php

namespace App\Models\Bonsae;

use Illuminate\Database\Eloquent\Model;

class BonsaeUser extends Model
{
    protected $connection = 'bonsae';
    protected $table = 'users';
    public $timestamps = false;

    protected $fillable = [
        'id', 'name', 'email', 'cpf', 'telephone',
        'profile_id', 'active', 'password',
    ];

    // Busca um usuário da Bonsae pelo e-mail
    public static function findByEmail(string $email): ?self
    {
        return self::where('email', $email)->first();
    }

    // Busca um usuário da Bonsae pelo CPF
    public static function findByCpf(string $cpf): ?self
    {
        return self::where('cpf', $cpf)->first();
    }
}