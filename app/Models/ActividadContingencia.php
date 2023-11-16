<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ActividadContingencia extends Model
{
    use HasFactory;
    protected $table = "actividades_contingencias";

    protected $fillable = [
        "titulo",
        "antes",
        "durante",
        "despues",
        "fecha_registro",
    ];
}
