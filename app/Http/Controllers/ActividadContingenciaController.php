<?php

namespace App\Http\Controllers;

use App\Models\ActividadContingencia;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ActividadContingenciaController extends Controller
{
    public $validacion = [
        'titulo' => 'required|min:2',
        'antes' => 'required|min:2',
        'durante' => 'required|min:2',
        'despues' => 'required|min:2',
    ];

    public $mensajes = [
        'titulo.required' => 'Este campo es obligatorio',
        'titulo.min' => 'Debes ingressar al menos 4 carácteres',
        'antes.required' => 'Este campo es obligatorio',
        'antes.min' => 'Debes ingresar al menos 4 carácteres',
        'durante.required' => 'Este campo es obligatorio',
        'durante.min' => 'Debes ingresar al menos 4 carácteres',
        'despues.required' => 'Este campo es obligatorio',
        'despues.min' => 'Debes ingresar al menos 4 carácteres',
    ];

    public function index(Request $request)
    {
        $texto = $request->texto;
        $per_page = 10;

        $actividades_contingencias = ActividadContingencia::orderBy("id", "desc");

        if (isset($texto) && trim($texto) != '') {
            $actividades_contingencias = $actividades_contingencias->where("titulo", "LIKE", "%$texto%");
        }

        $actividades_contingencias = $actividades_contingencias->paginate($per_page);
        return response()->JSON(['actividades_contingencias' => $actividades_contingencias, 'per_page' => $per_page], 200);
    }
    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear el ActividadContingencia
            $nuevo_actividad_contingencia = ActividadContingencia::create([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "antes" => nl2br(mb_strtoupper($request->antes)),
                "durante" => nl2br(mb_strtoupper($request->durante)),
                "despues" => nl2br(mb_strtoupper($request->despues)),
                "fecha_registro" => date("Y-m-d")
            ]);
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_actividad_contingencia, "actividades_contingencias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->actividad_contingencia . ' REGISTRO UNA ACTIVIDAD DE CONTINGENCIA',
                'datos_original' => $datos_original,
                'modulo' => 'ACTIVIDADES DE CONTINGENCIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'actividad_contingencia' => $nuevo_actividad_contingencia,
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

    public function update(Request $request, ActividadContingencia $actividad_contingencia)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($actividad_contingencia, "actividades_contingencias");
            $actividad_contingencia->update([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "antes" => nl2br(mb_strtoupper($request->antes)),
                "durante" => nl2br(mb_strtoupper($request->durante)),
                "despues" => nl2br(mb_strtoupper($request->despues)),
            ]);
            $datos_nuevo = HistorialAccion::getDetalleRegistro($actividad_contingencia, "actividades_contingencias");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->actividad_contingencia . ' MODIFICÓ UNA ACTIVIDAD DE CONTINGENCIA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ACTIVIDADES DE CONTINGENCIAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'actividad_contingencia' => $actividad_contingencia,
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

    public function show(ActividadContingencia $actividad_contingencia)
    {
        return response()->JSON([
            'sw' => true,
            'actividad_contingencia' => $actividad_contingencia
        ], 200);
    }

    public function destroy(ActividadContingencia $actividad_contingencia)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($actividad_contingencia, "actividades_contingencias");
            $actividad_contingencia->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->actividad_contingencia . ' ELIMINÓ UNA ACTIVIDAD DE CONTINGENCIA',
                'datos_original' => $datos_original,
                'modulo' => 'ACTIVIDADES DE CONTINGENCIAS',
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
