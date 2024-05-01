<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Funcionario Plan de Calidad</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1.5cm;
            margin-bottom: 0.3cm;
            margin-left: 0.3cm;
            margin-right: 0.3cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            margin-top: 20px;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 9pt;
        }

        table tbody tr td {
            font-size: 8pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            width: 200px;
            height: 90px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            margin-bottom: 15px;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            margin-top: 15px;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .cumplimiento {
            position: absolute;
            width: 150px;
            right: 0px;
            top: 86px;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #222222;
            color: white;
        }

        .txt_rojo {}

        .img_celda img {
            width: 45px;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @inject('o_plan_calidad', 'App\Models\PlanCalidad')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
            {{ $configuracion->first()->logo }}
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">FUNCIONARIO PLAN DE CONTINGENCIAS</h4>
        <h4 class="fecha">Expedido: {{ date('d-m-Y') }}</h4>
    </div>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="5%">FOTO</th>
                <th>NOMBRE</th>
                <th>PLAN DE CONTINGENCIAS</th>
                <th>ROLES Y FUNCIONES</th>
                <th>AMENAZAS Y SEGURIDAD</th>
                <th>ACTIVIDADES DE CONTINGENCIAS</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($usuarios as $user)
                @php
                    $c_plan_contingencias = $o_plan_calidad
                        ->where('user_id', $user->id)
                        ->where('plan_contingencia_id', '!=', null)
                        ->count();
                    $c_roles_funciones = $o_plan_calidad
                        ->where('user_id', $user->id)
                        ->where('rol_funcion_id', '!=', null)
                        ->count();
                    $c_amenazas_seguridad = $o_plan_calidad
                        ->where('user_id', $user->id)
                        ->where('amenaza_seguridad_id', '!=', null)
                        ->count();
                    $c_actividades_contingencias = $o_plan_calidad
                        ->where('user_id', $user->id)
                        ->where('actividad_contingencia_id', '!=', null)
                        ->count();
                @endphp
                <tr>
                    <td class="centreado">{{ $cont++ }}</td>
                    <td class="centreado">{{ $user->full_name }}</td>
                    <td class="centreado">{{ $c_plan_contingencias }}</td>
                    <td class="centreado">{{ $c_roles_funciones }}</td>
                    <td class="centreado">{{ $c_amenazas_seguridad }}</td>
                    <td class="centreado">{{ $c_actividades_contingencias }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>

</html>
