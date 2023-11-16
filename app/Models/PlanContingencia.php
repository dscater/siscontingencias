<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanContingencia extends Model
{
    use HasFactory;

    protected $fillable = [
        "titulo",
        "descripcion",
        "fecha_registro",
    ];
}
