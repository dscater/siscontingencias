<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanArchivo extends Model
{
    use HasFactory;

    protected $fillable = [
        "plan_calidad_id",
        "archivo",
        "ext",
    ];

    protected $appends = ["url_file", "url_archivo", "name"];

    public function getUrlFileAttribute()
    {
        $array_imgs = ["jpg", "jpeg", "png", "webp", "gif"];
        if (in_array($this->ext, $array_imgs)) {
            return asset("/files/" . $this->archivo);
        }
        return asset("/imgs/attach.png");
    }

    public function getUrlArchivoAttribute()
    {
        return asset("/files/" . $this->archivo);
    }

    public function getNameAttribute()
    {
        return $this->archivo;
    }

    public function plan_calidad()
    {
        return $this->belongsTo(PlanCalidad::class, 'plan_calidad_id');
    }
}
