<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlanCalidadsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('plan_calidads', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->text("actividad");
            $table->string("norma");
            $table->unsignedBigInteger("plan_contingencia_id")->nullable();
            $table->unsignedBigInteger("rol_funcion_id")->nullable();
            $table->unsignedBigInteger("amenaza_seguridad_id")->nullable();
            $table->unsignedBigInteger("actividad_contingencia_id")->nullable();
            $table->text("objetivo");
            $table->text("registros");
            $table->string("estado");
            $table->date("fecha_registro");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('plan_calidads');
    }
}
