<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\PlanContingencia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PlanContingenciaController extends Controller
{
    public $validacion = [
        'titulo' => 'required|min:2',
        'descripcion' => 'required|min:2',
    ];

    public $mensajes = [
        'titulo.required' => 'Este campo es obligatorio',
        'titulo.min' => 'Debes ingressar al menos 4 carácteres',
        'descripcion.required' => 'Este campo es obligatorio',
        'descripcion.min' => 'Debes ingresar al menos 4 carácteres',
    ];

    public function index(Request $request)
    {
        $texto = $request->texto;
        $per_page = 10;

        $plan_contingencias = PlanContingencia::orderBy("id", "desc");

        if (isset($texto) && trim($texto) != '') {
            $plan_contingencias = $plan_contingencias->where("titulo", "LIKE", "%$texto%");
        }

        $plan_contingencias = $plan_contingencias->paginate($per_page);
        return response()->JSON(['plan_contingencias' => $plan_contingencias, 'per_page' => $per_page], 200);
    }
    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear el PlanContingencia

            $nuevo_plan_contingencia = PlanContingencia::create([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "descripcion" => nl2br(mb_strtoupper($request->descripcion)),
                "fecha_registro" => date("Y-m-d")
            ]);
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_plan_contingencia, "plan_contingencias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->plan_contingencia . ' REGISTRO UN PLAN DE CONTINGENCIA',
                'datos_original' => $datos_original,
                'modulo' => 'PLAN DE CONTINGENCIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'plan_contingencia' => $nuevo_plan_contingencia,
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

    public function update(Request $request, PlanContingencia $plan_contingencia)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_contingencia, "plan_contingencias");
            $plan_contingencia->update([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "descripcion" => nl2br(mb_strtoupper($request->descripcion)),
            ]);
            $datos_nuevo = HistorialAccion::getDetalleRegistro($plan_contingencia, "plan_contingencias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->plan_contingencia . ' MODIFICÓ UN PLAN DE CONTINGENCIA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PLAN DE CONTINGENCIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'plan_contingencia' => $plan_contingencia,
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

    public function show(PlanContingencia $plan_contingencia)
    {
        return response()->JSON([
            'sw' => true,
            'plan_contingencia' => $plan_contingencia
        ], 200);
    }

    public function destroy(PlanContingencia $plan_contingencia)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_contingencia, "plan_contingencias");
            $plan_contingencia->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->plan_contingencia . ' ELIMINÓ UN PLAN DE CONTINGENCIA',
                'datos_original' => $datos_original,
                'modulo' => 'PLAN DE CONTINGENCIAS',
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
