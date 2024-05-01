<?php

namespace App\Http\Controllers;

use App\Models\AmenazaSeguridad;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class AmenazaSeguridadController extends Controller
{
    public $validacion = [
        'titulo' => 'required|min:2',
        'descripcion' => 'required|min:2',
        'consecuencias' => 'required|min:2',
    ];

    public $mensajes = [
        'titulo.required' => 'Este campo es obligatorio',
        'titulo.min' => 'Debes ingressar al menos 4 carácteres',
        'descripcion.required' => 'Este campo es obligatorio',
        'descripcion.min' => 'Debes ingresar al menos 4 carácteres',
        'consecuencias.required' => 'Este campo es obligatorio',
        'consecuencias.min' => 'Debes ingresar al menos 4 carácteres',
    ];

    public function index(Request $request)
    {
        $texto = $request->texto;
        $per_page = 10;

        $amenazas_seguridad = AmenazaSeguridad::orderBy("id", "desc");

        if (isset($texto) && trim($texto) != '') {
            $amenazas_seguridad = $amenazas_seguridad->where(DB::raw("CONCAT(titulo,' ',descripcion,' ',consecuencias)"), "LIKE", "%$texto%");
        }

        $amenazas_seguridad = $amenazas_seguridad->paginate($per_page);
        return response()->JSON(['amenazas_seguridad' => $amenazas_seguridad, 'per_page' => $per_page], 200);
    }

    public function lista(Request $request)
    {
        $amenazas_seguridad = AmenazaSeguridad::orderBy("id", "desc");
        $amenazas_seguridad = $amenazas_seguridad->get();
        return response()->JSON(['amenazas_seguridad' => $amenazas_seguridad], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // crear el AmenazaSeguridad
            $nuevo_amenaza_seguridad = AmenazaSeguridad::create([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "descripcion" => nl2br(mb_strtoupper($request->descripcion)),
                "consecuencias" => nl2br(mb_strtoupper($request->consecuencias)),
                "fecha_registro" => date("Y-m-d")
            ]);
            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_amenaza_seguridad, "amenazas_seguridad");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->amenaza_seguridad . ' REGISTRO UNA AMENAZA Y SEGURIDAD',
                'datos_original' => $datos_original,
                'modulo' => 'AMENAZAS Y SEGURIDAD',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'amenaza_seguridad' => $nuevo_amenaza_seguridad,
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

    public function update(Request $request, AmenazaSeguridad $amenaza_seguridad)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($amenaza_seguridad, "amenazas_seguridad");
            $amenaza_seguridad->update([
                "titulo" => nl2br(mb_strtoupper($request->titulo)),
                "descripcion" => nl2br(mb_strtoupper($request->descripcion)),
                "consecuencias" => nl2br(mb_strtoupper($request->consecuencias)),
            ]);
            $datos_nuevo = HistorialAccion::getDetalleRegistro($amenaza_seguridad, "amenazas_seguridad");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->amenaza_seguridad . ' MODIFICÓ UNA AMENAZA Y SEGURIDAD',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'AMENAZAS Y SEGURIDAD',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'amenaza_seguridad' => $amenaza_seguridad,
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

    public function show(AmenazaSeguridad $amenaza_seguridad)
    {
        return response()->JSON([
            'sw' => true,
            'amenaza_seguridad' => $amenaza_seguridad
        ], 200);
    }

    public function destroy(AmenazaSeguridad $amenaza_seguridad)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($amenaza_seguridad, "amenazas_seguridad");
            $amenaza_seguridad->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->amenaza_seguridad . ' ELIMINÓ UNA AMENAZA Y SEGURIDAD',
                'datos_original' => $datos_original,
                'modulo' => 'AMENAZAS Y SEGURIDAD',
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
