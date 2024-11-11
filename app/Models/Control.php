<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Control extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "asignados",
        "pendientes",
        "observados",
        "finalizados",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
