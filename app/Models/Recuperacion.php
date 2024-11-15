<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recuperacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "email",
        "cod",
        "recuperado",
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
