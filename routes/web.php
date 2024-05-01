<?php

use App\Http\Controllers\ActividadContingenciaController;
use App\Http\Controllers\AmenazaSeguridadController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\PlanArchivoController;
use App\Http\Controllers\PlanCalidadController;
use App\Http\Controllers\PlanContingenciaController;
use App\Http\Controllers\RecuperacionController;
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


Route::get("olvide_mi_contrasenia", [RecuperacionController::class, 'olvide_mi_contrasenia'])->name("olvide_mi_contrasenia");
Route::post("registrar_ci", [RecuperacionController::class, 'registrar_ci'])->name("registrar_ci");
Route::get("recuperacion/{recuperacion}", [RecuperacionController::class, 'recuperacion'])->name("recuperacion");
Route::post("recuperacion/{recuperacion}", [RecuperacionController::class, 'registro_recuperacion'])->name("registro_recuperacion");

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

        // plan_calidads
        Route::resource('plan_calidads', PlanCalidadController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // plan archivos
        Route::delete('plan_archivos/{plan_archivo}', [PlanArchivoController::class, 'destroy']);

        // plan_contingencias
        Route::get('plan_contingencias/lista', [PlanContingenciaController::class, 'lista']);
        Route::resource('plan_contingencias', PlanContingenciaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // roles_funciones
        Route::get('roles_funciones/lista', [RolFuncionController::class, 'lista']);
        Route::get('roles_funciones/{rol_funcion}', [RolFuncionController::class, 'show']);
        Route::put('roles_funciones/{rol_funcion}', [RolFuncionController::class, 'update']);
        Route::delete('roles_funciones/{rol_funcion}', [RolFuncionController::class, 'destroy']);
        Route::resource('roles_funciones', RolFuncionController::class)->only([
            'index', 'store'
        ]);

        // amenzas_seguridad
        Route::get('amenazas_seguridad/lista', [AmenazaSeguridadController::class, 'lista']);
        Route::get('amenazas_seguridad/{amenaza_seguridad}', [AmenazaSeguridadController::class, 'show']);
        Route::put('amenazas_seguridad/{amenaza_seguridad}', [AmenazaSeguridadController::class, 'update']);
        Route::delete('amenazas_seguridad/{amenaza_seguridad}', [AmenazaSeguridadController::class, 'destroy']);
        Route::resource('amenazas_seguridad', AmenazaSeguridadController::class)->only([
            'index', 'store'
        ]);

        // actividades_contingencias
        Route::get('actividades_contingencias/lista', [ActividadContingenciaController::class, 'lista']);
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
        Route::post('reportes/funcionario_plan_calidad', [ReporteController::class, 'funcionario_plan_calidad']);
        Route::post('reportes/funcionario_plan_calidad_pdf', [ReporteController::class, 'funcionario_plan_calidad_pdf']);
    });
});

// ADMINISTRACIÓN
Route::get('/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');
