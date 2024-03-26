<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pet extends Model
{
    use HasFactory;

    protected $table = "mascotas";

    protected $fillable = ['nombre', 'tipo', 'raza', 'edad', 'cliente_id'];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function consults()
    {
        return $this->hasMany(Consult::class);
    }
}
