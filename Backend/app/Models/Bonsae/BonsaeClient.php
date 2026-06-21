<?php

namespace App\Models\Bonsae;

use Illuminate\Database\Eloquent\Model;

class BonsaeClient extends Model
{
    protected $connection = 'bonsae';
    protected $table = 'clients';
    public $timestamps = false;

    protected $fillable = [
        'id', 'name', 'social_name', 'kind_of_person',
        'cpf', 'cnpj', 'rg', 'issuing_body', 'uf_issuing_body',
        'birth_date', 'nationality', 'naturalness',
        'marital_status', 'profession', 'education', 'monthly_income',
        'mother_name', 'father_name', 'voter_registration', 'pis',
        'telephone', 'telephone2', 'email', 'email2',
        'creator_id', 'address_id',
    ];

    public function address()
    {
        return $this->hasOne(BonsaeAddress::class, 'client_id', 'id');
    }
}