<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AmenazaSeguridad extends Model
{
    use HasFactory;
    protected $table = "amenazas_seguridad";

    protected $fillable = [
        "titulo",
        "descripcion",
        "consecuencias",
        "fecha_registro",
    ];
}
