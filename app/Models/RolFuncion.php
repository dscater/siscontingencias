<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RolFuncion extends Model
{
    use HasFactory;

    protected $table = "roles_funciones";

    protected $fillable = [
        "titulo",
        "rol",
        "funciones_atribuciones",
        "fecha_registro",
    ];
}
