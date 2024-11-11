<?php

namespace App\Http\Controllers;

use App\Models\Control;
use App\Models\HistorialAccion;
use App\Models\PlanCalidad;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ControlController extends Controller
{
    public $validacion = [
        "user_id" => "required",
        "actividad" => "required",
        "norma" => "required",
        "objetivo" => "required",
        "registros" => "required",
    ];

    public $mensajes = [
        "user_id.required" => "Este campo es obligatorio",
        "actividad.required" => "Este campo es obligatorio",
        "norma.required" => "Este campo es obligatorio",
        "objetivo.required" => "Este campo es obligatorio",
        "registros.required" => "Este campo es obligatorio",
        "plan_contingencia_id.required" => "Este campo es obligatorio",
        "rol_funcion_id.required" => "Este campo es obligatorio",
        "amenaza_seguridad_id.required" => "Este campo es obligatorio",
        "actividad_contingencia_id.required" => "Este campo es obligatorio",
    ];

    public function index(Request $request)
    {
        // // inicializa control de usuarios
        // $users = User::where("tipo", "FUNCIONARIO")->get();
        // // Log::debug(count($users));
        // foreach ($users as $item) {
        //     $existe = Control::where("user_id", $item->id)
        //         ->get()->first();
        //     $c_plan_calidads  = PlanCalidad::where("user_id", $item->id)->count();
        //     if (!$existe) {
        //         $existe = Control::create([
        //             "user_id" => $item->id,
        //             "asignados" => $c_plan_calidads,
        //             "pendientes" => $c_plan_calidads,
        //             "observados" => 0,
        //             "finalizados" => 0,
        //         ]);
        //     }
        // }

        $controls = Control::with(["user"])->get();
        return response()->JSON(['controls' => $controls, 'total' => count($controls)], 200);
    }

    public function seguimiento(Control $control)
    {
        $user = $control->user;
        $plan_calidads = PlanCalidad::with(["user", "plan_archivos"])->where("user_id", $user->id)->get();
        return response()->JSON(["plan_calidads" => $plan_calidads, "user" => $user, "total" => count($plan_calidads)]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Plan de Calidad
            $nuevo_control = Control::create(array_map('mb_strtoupper', $request->except('plan_archivos')));

            $nuevo_control->plan_seguimiento()->create([
                "user_id" => $nuevo_control->user_id,
                "estado" => "PENDIENTE",
                "descripcion" => "",
            ]);

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_control, "controls");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO' . Auth::user()->control . ' REGISTRO UN CONTROL',
                'datos_original' => $datos_original,
                'modulo' => 'CONTROL DE PLAN DE CALIDAD',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'control' => $nuevo_control,
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

    public function update(Request $request, Control $control)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($control, "controls");
            $control->update(array_map('mb_strtoupper', $request->except('plan_archivos')));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($control, "controls");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO' . Auth::user()->control . ' MODIFICÓ UN CONTROL',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'CONTROL DE PLAN DE CALIDAD',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'control' => $control,
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

    public function show(Control $control)
    {
        return response()->JSON([
            'sw' => true,
            'control' => $control
        ], 200);
    }


    public function destroy(Control $control)
    {
        DB::beginTransaction();
        try {
            foreach ($control->plan_archivos as $file) {
                \File::delete(public_path() . '/files/' . $file->archivo);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($control, "controls");
            $control->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO' . Auth::user()->control . ' ELIMINÓ UN CONTROL',
                'datos_original' => $datos_original,
                'modulo' => 'CONTROL DE PLAN DE CALIDAD',
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
