<?php

namespace App\Models\Bonsae;

use Illuminate\Database\Eloquent\Model;

class BonsaeAddress extends Model
{
    protected $connection = 'bonsae';
    protected $table = 'addresses';
    public $timestamps = false;
}