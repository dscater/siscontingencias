<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\RolFuncion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class RolFuncionController extends Controller
{
    public $validacion = [
        'titulo' => 'required|min:2',
        'rol' => 'required|min:2',
        'funciones_atribuciones' => 'required|min:2',
    ];

    public $mensajes = [
        'titulo.required' => 'Este campo es obligatorio',
        'titulo.min' => 'Debes ingressar al menos 4 carácteres',
        'rol.required' => 'Este campo es obligatorio',
        'rol.min' => 'Debes ingresar al menos 4 carácteres',
        'funciones_atribuciones.required' => 'Este campo es obligatorio',
        'funciones_atribuciones.min' => 'Debes ingresar al menos 4 carácteres',
    ];

    public function index(Request $request)
    {
        $texto = $request->texto;
        $per_page = 10;

        $roles_funciones = RolFuncion::orderBy("id", "desc");

        if (isset($texto) && trim($texto) != '') {
            $roles_funciones = $roles_funciones->where("titulo", "LIKE", "%$texto%");
        }

        $roles_funciones = $roles_funciones->paginate($per_page);
        return response()->JSON(['roles_funciones' => $roles_funciones, 'per_page' => $per_page], 200);
    }
    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear el RolFuncion
            $nuevo_rol_funcion = RolFuncion::create([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "rol" => nl2br(mb_strtoupper($request->rol)),
                "funciones_atribuciones" => nl2br(mb_strtoupper($request->funciones_atribuciones)),
                "fecha_registro" => date("Y-m-d")
            ]);
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_rol_funcion, "roles_funciones");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->rol_funcion . ' REGISTRO UN ROL Y FUNCIÓN',
                'datos_original' => $datos_original,
                'modulo' => 'ROLES Y FUNCIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'rol_funcion' => $nuevo_rol_funcion,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, RolFuncion $rol_funcion)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($rol_funcion, "roles_funciones");
            $rol_funcion->update([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "rol" => nl2br(mb_strtoupper($request->rol)),
                "funciones_atribuciones" => nl2br(mb_strtoupper($request->funciones_atribuciones)),
            ]);
            $datos_nuevo = HistorialAccion::getDetalleRegistro($rol_funcion, "roles_funciones");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->rol_funcion . ' MODIFICÓ UN ROL Y FUNCIÓN',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ROLES Y FUNCIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'rol_funcion' => $rol_funcion,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(RolFuncion $rol_funcion)
    {
        return response()->JSON([
            'sw' => true,
            'rol_funcion' => $rol_funcion
        ], 200);
    }

    public function destroy(RolFuncion $rol_funcion)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($rol_funcion, "roles_funciones");
            $rol_funcion->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->rol_funcion . ' ELIMINÓ UN ROL Y FUNCIÓN',
                'datos_original' => $datos_original,
                'modulo' => 'ROLES Y FUNCIONES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
