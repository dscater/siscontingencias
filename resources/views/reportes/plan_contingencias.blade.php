<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Plan de Contingencias</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1.5cm;
            margin-bottom: 1cm;
            margin-left: 1cm;
            margin-right: 1cm;
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
            font-size: 7pt;
        }

        table tbody tr td {
            font-size: 6pt;
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

        .txt-lg {
            font-size: 0.8em;
        }

        .bold {
            font-weight: bold;
        }

        .img_celda img {
            width: 45px;
        }

        .nueva_pagina {
            page-break-after: always;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    @if ($filtro != 'Filtrar' || $tipo == 'PLAN DE CONTINGENCIAS')
        <div class="encabezado">
            <div class="logo">
                <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
                {{ $configuracion->first()->logo }}
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">PLAN DE CONTINGENCIAS</h4>
        </div>
        @foreach ($plan_contingencias as $value)
            <table border="1">
                <tbody>
                    <tr>
                        <td class="bg-principal txt-lg bold">{{ $value->titulo }}</td>
                    </tr>
                    <tr>
                        <td>{!! $value->descripcion !!}</td>
                    </tr>
                </tbody>
            </table>
        @endforeach
        @if ($filtro != 'Filtrar')
            <div class="nueva_pagina"></div>
        @endif
    @endif
    @if ($filtro != 'Filtrar' || $tipo == 'ROLES Y FUNCIONES')
        <div class="encabezado">
            <div class="logo">
                <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
                {{ $configuracion->first()->logo }}
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">ROLES Y FUNCIONES</h4>
        </div>
        @foreach ($roles_funciones as $value)
            <table border="1">
                <tbody>
                    <tr>
                        <td class="bg-principal txt-lg bold" colspan="2">{{ $value->titulo }}</td>
                    </tr>
                    <tr>
                        <td class="txt-lg bold" width="30%">Roles</td>
                        <td class="txt-lg bold">Funciones y Atribuciones Específicas</td>
                    </tr>
                    <tr>
                        <td>{!! $value->rol !!}</td>
                        <td>{!! $value->funciones_atribuciones !!}</td>
                    </tr>
                </tbody>
            </table>
        @endforeach
        @if ($filtro != 'Filtrar')
            <div class="nueva_pagina"></div>
        @endif
    @endif
    @if ($filtro != 'Filtrar' || $tipo == 'AMENAZAS Y SEGURIDAD')
        <div class="encabezado">
            <div class="logo">
                <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
                {{ $configuracion->first()->logo }}
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">AMENAZAS Y SEGURIDAD</h4>
        </div>
        @foreach ($amenazas_seguridad as $value)
            <table border="1">
                <tbody>
                    <tr>
                        <td class="bg-principal txt-lg bold" colspan="2">{{ $value->titulo }}</td>
                    </tr>
                    <tr>
                        <td class="" colspan="2">{{ $value->descripcion }}</td>
                    </tr>
                    <tr>
                        <td class="bold txt-lg centreado" width="20%">CONSECUENCIAS</td>
                        <td>{!! $value->consecuencias !!}</td>
                    </tr>
                </tbody>
            </table>
        @endforeach
        @if ($filtro != 'Filtrar')
            <div class="nueva_pagina"></div>
        @endif
    @endif
    @if ($filtro != 'Filtrar' || $tipo == 'ACTIVIDADES DE CONTINGENCIAS')
        <div class="encabezado">
            <div class="logo">
                <img src="{{ asset('imgs/' . $configuracion->first()->logo) }}">
                {{ $configuracion->first()->logo }}
            </div>
            <h2 class="titulo">
                {{ $configuracion->first()->razon_social }}
            </h2>
            <h4 class="texto">ACTIVIDADES DE CONTINGENCIAS</h4>
        </div>
        @foreach ($actividades_contingencias as $value)
            <table border="1">
                <tbody>
                    <tr>
                        <td class="bg-principal txt-lg bold" colspan="3">{{ $value->titulo }}</td>
                    </tr>
                    <tr>
                        <td class="txt-lg bold centreado" width="33.33%">Actividades Antes</td>
                        <td class="txt-lg bold centreado" width="33.33%">Actividades Durante</td>
                        <td class="txt-lg bold centreado">Actividades Después</td>
                    </tr>
                    <tr>
                        <td>{!! $value->antes !!}</td>
                        <td>{!! $value->durante !!}</td>
                        <td>{!! $value->despues !!}</td>
                    </tr>
                </tbody>
            </table>
        @endforeach
    @endif
</body>

</html>
