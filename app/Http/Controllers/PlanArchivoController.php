<?php

namespace App\Http\Controllers;

use App\Models\PlanArchivo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PlanArchivoController extends Controller
{
    public function destroy(PlanArchivo $plan_archivo)
    {
        DB::beginTransaction();
        try {
            $plan_calidad = $plan_archivo->plan_calidad;
            $ruta_archivo  = public_path("/files/" . $plan_archivo->archivo);
            $plan_archivo->delete();
            DB::commit();
            if (file_exists($ruta_archivo)) {
                \File::delete($ruta_archivo);
            }
            return response()->JSON([
                "message" => "Registro eliminado",
                "plan_calidad" => $plan_calidad->load("plan_archivos")
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                "message" => $e->getMessage()
            ], 500);
        }
    }
}
