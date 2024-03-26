<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;

    protected $table = "clientes";

    protected $fillable = ['nombre', 'telefono', 'email', 'direccion'];

    public function customers()
    {
        return $this->hasMany(Customer::class);
    }
}
