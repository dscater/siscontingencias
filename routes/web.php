<?php

use App\Http\Controllers\ActividadContingenciaController;
use App\Http\Controllers\AmenazaSeguridadController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PlanContingenciaController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RolFuncionController;
use App\Http\Controllers\UserController;
use App\Models\RolFuncion;
use Illuminate\Support\Facades\Route;

// VACIAR CACHE
Route::get('/cache_clear', function () {
    Artisan::call("route:clear");
    Artisan::call("route:cache");
    Artisan::call("view:clear");
    Artisan::call("config:cache");
    Artisan::call("optimize");

    return 'Cache borrada correctamente<br/><a href="' . url("/") . '">Volver al inicio<a>';
});

// LOGIN
Route::post('/login', [LoginController::class, 'login']);
Route::post('/logout', [LoginController::class, 'logout']);

// CONFIGURACIÓN
Route::get('/configuracion/getConfiguracion', [ConfiguracionController::class, 'getConfiguracion']);

Route::middleware(['auth'])->group(function () {
    Route::post('/configuracion/update', [ConfiguracionController::class, 'update']);

    Route::prefix('admin')->group(function () {
        // Usuarios
        Route::post('usuarios/updatePassword/{usuario}', [UserController::class, 'updatePassword']);
        Route::get('usuarios/getUsuarioTipo', [UserController::class, 'getUsuarioTipo']);
        Route::get('usuarios/getUsuario/{usuario}', [UserController::class, 'getUsuario']);
        Route::patch('usuarios/asignarConfiguracion/{usuario}', [UserController::class, 'asignarConfiguracion']);
        Route::get('usuarios/userActual', [UserController::class, 'userActual']);
        Route::get('usuarios/getInfoBox', [UserController::class, 'getInfoBox']);
        Route::get('usuarios/getPermisos/{usuario}', [UserController::class, 'getPermisos']);
        Route::get('usuarios/getEncargadosRepresentantes', [UserController::class, 'getEncargadosRepresentantes']);
        Route::post('usuarios/actualizaContrasenia/{usuario}', [UserController::class, 'actualizaContrasenia']);
        Route::post('usuarios/actualizaFoto/{usuario}', [UserController::class, 'actualizaFoto']);
        Route::resource('usuarios', UserController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // plan_contingencias
        Route::resource('plan_contingencias', PlanContingenciaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);


        // roles_funciones
        Route::get('roles_funciones/{rol_funcion}', [RolFuncionController::class, 'show']);
        Route::put('roles_funciones/{rol_funcion}', [RolFuncionController::class, 'update']);
        Route::delete('roles_funciones/{rol_funcion}', [RolFuncionController::class, 'destroy']);
        Route::resource('roles_funciones', RolFuncionController::class)->only([
            'index', 'store'
        ]);

        // amenzas_seguridad
        Route::get('amenazas_seguridad/{amenaza_seguridad}', [AmenazaSeguridadController::class, 'show']);
        Route::put('amenazas_seguridad/{amenaza_seguridad}', [AmenazaSeguridadController::class, 'update']);
        Route::delete('amenazas_seguridad/{amenaza_seguridad}', [AmenazaSeguridadController::class, 'destroy']);
        Route::resource('amenazas_seguridad', AmenazaSeguridadController::class)->only([
            'index', 'store'
        ]);

        // actividades_contingencias
        Route::get('actividades_contingencias/{actividad_contingencia}', [ActividadContingenciaController::class, 'show']);
        Route::put('actividades_contingencias/{actividad_contingencia}', [ActividadContingenciaController::class, 'update']);
        Route::delete('actividades_contingencias/{actividad_contingencia}', [ActividadContingenciaController::class, 'destroy']);
        Route::resource('actividades_contingencias', ActividadContingenciaController::class)->only([
            'index', 'store'
        ]);

        // REPORTES
        Route::post('reportes/usuarios', [ReporteController::class, 'usuarios']);
        Route::post('reportes/plan_contingencia', [ReporteController::class, 'plan_contingencia']);
        Route::post('reportes/cantidad_plan_contingencia', [ReporteController::class, 'cantidad_plan_contingencia']);
    });
});

// ADMINISTRACIÓN
Route::get('/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');
