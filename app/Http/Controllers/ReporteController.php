<?php

namespace App\Http\Controllers;

use App\Models\ActividadContingencia;
use App\Models\AmenazaSeguridad;
use App\Models\PlanCalidad;
use App\Models\PlanContingencia;
use App\Models\RolFuncion;
use App\Models\User;
use Illuminate\Http\Request;
use PDF;

class ReporteController extends Controller
{
    public function usuarios(Request $request)
    {
        $filtro =  $request->filtro;
        $usuarios = User::where('id', '!=', 1)->orderBy("paterno", "ASC")->get();

        if ($filtro == 'Tipo de usuario') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios = User::where('id', '!=', 1)->where('tipo', $request->tipo)->orderBy("paterno", "ASC")->get();
        }

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Usuarios.pdf');
    }

    public function plan_contingencia(Request $request)
    {
        $filtro =  $request->filtro;
        $tipo =  $request->tipo;

        if ($filtro == 'Filtrar') {
            $request->validate([
                "tipo" => "required"
            ], [
                "tipo.required" => "Debes seleccionar una opción"
            ]);
        }

        $plan_contingencias = PlanContingencia::all();
        $roles_funciones = RolFuncion::all();
        $amenazas_seguridad = AmenazaSeguridad::all();
        $actividades_contingencias = ActividadContingencia::all();

        $pdf = PDF::loadView('reportes.plan_contingencias', compact('plan_contingencias', 'roles_funciones', 'amenazas_seguridad', 'actividades_contingencias', 'filtro', 'tipo'))
            ->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('plan_contingencias.pdf');
    }
    public function cantidad_plan_contingencia(Request $request)
    {
        $filtro =  $request->filtro;
        $tipo =  $request->tipo;

        if ($filtro == 'Tipo') {
            $request->validate([
                "tipo" => "required"
            ], [
                "tipo.required" => "Debes seleccionar una opción"
            ]);
        }

        $plan_contingencias = PlanContingencia::all();
        $roles_funciones = RolFuncion::all();
        $amenazas_seguridad = AmenazaSeguridad::all();
        $actividades_contingencias = ActividadContingencia::all();

        $datos = [];

        $datos = [
            ["PLAN DE CONTINGENCIAS", (int)count($plan_contingencias)],
            ["ROLES Y FUNCIONES", (int)count($roles_funciones)],
            ["AMENAZAS Y SEGURIDAD", (int)count($amenazas_seguridad)],
            ["ACTIVIDADES DE CONTINGENCIAS", (int)count($actividades_contingencias)],
        ];

        if ($filtro != 'Todos' && $tipo == 'PLAN DE CONTINGENCIAS') {
            $datos = [
                ["PLAN DE CONTINGENCIAS", (int)count($plan_contingencias)],
            ];
        }

        if ($filtro != 'Todos' && $tipo == 'ROLES Y FUNCIONES') {
            $datos = [
                ["ROLES Y FUNCIONES", (int)count($roles_funciones)],
            ];
        }

        if ($filtro != 'Todos' && $tipo == 'AMENAZAS Y SEGURIDAD') {
            $datos = [
                ["AMENAZAS Y SEGURIDAD", (int)count($amenazas_seguridad)],
            ];
        }

        if ($filtro != 'Todos' && $tipo == 'ACTIVIDADES DE CONTINGENCIAS') {
            $datos = [
                ["ACTIVIDADES DE CONTINGENCIAS", (int)count($actividades_contingencias)],
            ];
        }

        return response()->JSON([
            "datos" => $datos
        ]);
    }

    public function funcionario_plan_calidad(Request $request)
    {
        $categories = [];
        $series = [
            [
                "name" => "PLAN DE CONTINGENCAS",
                "data" => [],
            ],
            [
                "name" => "ROLES Y FUNCIONES",
                "data" => [],
            ],
            [
                "name" => "AMENAZAS Y SEGURIDAD",
                "data" => [],
            ],
            [
                "name" => "ACTIVIDADES DE CONTINGENCIAS",
                "data" => [],
            ]
        ];
        $usuarios = User::where("tipo", "FUNCIONARIO")->get();
        foreach ($usuarios as $user) {
            $categories[] = $user->full_name;
            $c_plan_contingencias = PlanCalidad::where('user_id', $user->id)
                ->where('plan_contingencia_id', '!=', null)
                ->count();
            $c_roles_funciones = PlanCalidad::where('user_id', $user->id)
                ->where('rol_funcion_id', '!=', null)
                ->count();
            $c_amenazas_seguridad = PlanCalidad::where('user_id', $user->id)
                ->where('amenaza_seguridad_id', '!=', null)
                ->count();
            $c_actividades_contingencias = PlanCalidad::where('user_id', $user->id)
                ->where('actividad_contingencia_id', '!=', null)
                ->count();
            $series[0]["data"][] = $c_plan_contingencias;
            $series[1]["data"][] = $c_roles_funciones;
            $series[2]["data"][] = $c_amenazas_seguridad;
            $series[3]["data"][] = $c_actividades_contingencias;
        }

        return response()->JSON([
            "categories" => $categories,
            "series" => $series,
        ]);
    }

    public function funcionario_plan_calidad_pdf(Request $request)
    {
        $usuarios = User::where("tipo", "FUNCIONARIO")->get();

        $pdf = PDF::loadView('reportes.funcionario_plan_calidad', compact("usuarios"))
            ->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('funcionario_plan_calidad.pdf');
    }

    public function plan_calidad_estados(Request $request)
    {
        $datos = [];
        $series = ["PENDIENTE", "OBSERVADO", "FINALIZADO"];
        $colores = ["#0779ad", "#e25402", "#00e727"];
        foreach ($series as $index => $value) {
            $plan_calidads = PlanCalidad::where("estado", $value)->count();
            $datos[] = [
                'name' => $value, // Nombre del punto
                'y' => (float)$plan_calidads, // Valor de la columna
                'color' => $colores[$index] // Color personalizado
            ];
        }

        return response()->JSON([
            "datos" => $datos,
        ]);
    }
}
