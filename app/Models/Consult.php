<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Consult extends Model
{
    use HasFactory;

    protected $table = "consultas";

    protected $fillable = ['fecha', 'motivo', 'diagnostico', 'tratamiento', 'mascota_id'];

    public function consults()
    {
        return $this->belongsTo(Consult::class);
    }
}

