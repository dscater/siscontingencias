<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanCalidad extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "actividad",
        "norma",
        "plan_contingencia_id",
        "rol_funcion_id",
        "amenaza_seguridad_id",
        "actividad_contingencia_id",
        "objetivo",
        "registros",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function plan_contingencia()
    {
        return $this->belongsTo(PlanContingencia::class, 'plan_contingencia_id');
    }

    public function rol_funcion()
    {
        return $this->belongsTo(RolFuncion::class, 'rol_funcion_id');
    }

    public function amenaza_seguridad()
    {
        return $this->belongsTo(AmenazaSeguridad::class, 'amenaza_seguridad_id');
    }

    public function actividad_contingencia()
    {
        return $this->belongsTo(ActividadContingencia::class, 'actividad_contingencia_id');
    }

    public function plan_archivos()
    {
        return $this->hasMany(PlanArchivo::class, 'plan_calidad_id');
    }
}
