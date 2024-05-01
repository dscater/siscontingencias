<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\PlanCalidad;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class PlanCalidadController extends Controller
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
        $plan_calidads = [];
        if (Auth::user()->tipo == 'FUNCIONARIO') {
            $plan_calidads = PlanCalidad::with(["user", "plan_archivos"])
                ->where("user_id", Auth::user()->id)->get();
        } else {
            $plan_calidads = PlanCalidad::with(["user", "plan_archivos"])->get();
        }
        return response()->JSON(['plan_calidads' => $plan_calidads, 'total' => count($plan_calidads)], 200);
    }

    public function store(Request $request)
    {
        $plan_contingencia_id = $request->plan_contingencia_id;
        $rol_funcion_id = $request->rol_funcion_id;
        $amenaza_seguridad_id = $request->amenaza_seguridad_id;
        $actividad_contingencia_id = $request->actividad_contingencia_id;

        unset($request["plan_contingencia_id"]);
        unset($request["rol_funcion_id"]);
        unset($request["amenaza_seguridad_id"]);
        unset($request["actividad_contingencia_id"]);

        if ($request->norma == 'PLAN DE CONTIGENCIAS') {
            $this->validacion["plan_contingencia_id"] = "required";
            $request["plan_contingencia_id"] = $plan_contingencia_id;
        }

        if ($request->norma == 'ROLES Y FUNCIONES') {
            $this->validacion["rol_funcion_id"] = "required";
            $request["rol_funcion_id"] = $rol_funcion_id;
        }
        if ($request->norma == 'AMENAZAS Y SEGURDAD') {
            $this->validacion["amenaza_seguridad_id"] = "required";
            $request["amenaza_seguridad_id"] = $amenaza_seguridad_id;
        }
        if ($request->norma == 'ACTIVIDADES DE CONTINGENCIAS') {
            $this->validacion["actividad_contingencia_id"] = "required";
            $request["actividad_contingencia_id"] = $actividad_contingencia_id;
        }

        $request->validate($this->validacion, $this->mensajes);

        $request['fecha_registro'] = date('Y-m-d');
        DB::beginTransaction();
        try {
            // crear el Plan de Calidad
            $nuevo_plan_calidad = PlanCalidad::create(array_map('mb_strtoupper', $request->except('plan_archivos')));

            if ($request->hasFile('plan_archivos')) {
                $plan_archivos = $request->plan_archivos;
                foreach ($plan_archivos as $key => $file) {
                    $file = $file;
                    $extension = $file->getClientOriginalExtension();
                    $nom_file = time() . '_' . $key . $nuevo_plan_calidad->id . '.' . $extension;
                    $nuevo_plan_calidad->plan_archivos()->create([
                        "archivo" => $nom_file,
                        "ext" => $extension,
                    ]);
                    $file->move(public_path() . '/files/', $nom_file);
                }
            }
            $nuevo_plan_calidad->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_plan_calidad, "plan_calidads");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO' . Auth::user()->plan_calidad . ' REGISTRO UN PLAN DE CALIDAD',
                'datos_original' => $datos_original,
                'modulo' => 'PLAN DE CALIDADS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'plan_calidad' => $nuevo_plan_calidad,
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

    public function update(Request $request, PlanCalidad $plan_calidad)
    {

        $plan_contingencia_id = $request->plan_contingencia_id;
        $rol_funcion_id = $request->rol_funcion_id;
        $amenaza_seguridad_id = $request->amenaza_seguridad_id;
        $actividad_contingencia_id = $request->actividad_contingencia_id;

        unset($request["plan_contingencia_id"]);
        unset($request["rol_funcion_id"]);
        unset($request["amenaza_seguridad_id"]);
        unset($request["actividad_contingencia_id"]);

        if ($request->norma == 'PLAN DE CONTIGENCIAS') {
            $this->validacion["plan_contingencia_id"] = "required";
            $request["plan_contingencia_id"] = $plan_contingencia_id;
        }

        if ($request->norma == 'ROLES Y FUNCIONES') {
            $this->validacion["rol_funcion_id"] = "required";
            $request["rol_funcion_id"] = $rol_funcion_id;
        }
        if ($request->norma == 'AMENAZAS Y SEGURDAD') {
            $this->validacion["amenaza_seguridad_id"] = "required";
            $request["amenaza_seguridad_id"] = $amenaza_seguridad_id;
        }
        if ($request->norma == 'ACTIVIDADES DE CONTINGENCIAS') {
            $this->validacion["actividad_contingencia_id"] = "required";
            $request["actividad_contingencia_id"] = $actividad_contingencia_id;
        }

        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($plan_calidad, "plan_calidads");
            $plan_calidad->update(array_map('mb_strtoupper', $request->except('plan_archivos')));

            $plan_calidad->plan_contingencia_id = null;
            $plan_calidad->rol_funcion_id = null;
            $plan_calidad->amenaza_seguridad_id = null;
            $plan_calidad->actividad_contingencia_id = null;
            $plan_calidad->save();

            if ($request->norma == 'PLAN DE CONTIGENCIAS') {
                $plan_calidad->plan_contingencia_id = $plan_contingencia_id;
            }

            if ($request->norma == 'ROLES Y FUNCIONES') {
                $plan_calidad->rol_funcion_id = $rol_funcion_id;
            }
            if ($request->norma == 'AMENAZAS Y SEGURDAD') {
                $plan_calidad->amenaza_seguridad_id = $amenaza_seguridad_id;
            }
            if ($request->norma == 'ACTIVIDADES DE CONTINGENCIAS') {
                $plan_calidad->actividad_contingencia_id = $actividad_contingencia_id;
            }


            if ($request->hasFile('plan_archivos')) {
                $plan_archivos = $request->plan_archivos;
                foreach ($plan_archivos as $key => $file) {
                    $file = $file;
                    $extension = $file->getClientOriginalExtension();
                    $nom_file = time() . '_' . $key . $plan_calidad->id . '.' . $extension;
                    $plan_calidad->plan_archivos()->create([
                        "archivo" => $nom_file,
                        "ext" => $extension,
                    ]);
                    $file->move(public_path() . '/files/', $nom_file);
                }
            }
            $plan_calidad->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($plan_calidad, "plan_calidads");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO' . Auth::user()->plan_calidad . ' MODIFICÓ UN PLAN DE CALIDAD',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PLAN DE CALIDADS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'plan_calidad' => $plan_calidad,
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

    public function show(PlanCalidad $plan_calidad)
    {
        return response()->JSON([
            'sw' => true,
            'plan_calidad' => $plan_calidad
        ], 200);
    }


    public function destroy(PlanCalidad $plan_calidad)
    {
        DB::beginTransaction();
        try {
            foreach ($plan_calidad->plan_archivos as $file) {
                \File::delete(public_path() . '/files/' . $file->archivo);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($plan_calidad, "plan_calidads");
            $plan_calidad->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO' . Auth::user()->plan_calidad . ' ELIMINÓ UN PLAN DE CALIDAD',
                'datos_original' => $datos_original,
                'modulo' => 'PLAN DE CALIDADS',
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
