<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Recibo</title>
    <style type="text/css">
        * {
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }

        @page {
            margin-left: 2cm;
            margin-top: 1cm;
            margin-right: 1cm;
            margin-bottom: 1cm;
        }

        body {
            position: relative;
        }

        .titulo {
            margin-right: auto;
            margin-left: auto;
            margin-bottom: auto;
            width: 300px;
        }

        .titulo p.emp {
            text-align: center;
            font-size: 0.95em;
            padding: 0;
            margin-bottom: 0px;
        }

        .titulo p.dir {
            text-align: center;
            font-size: 0.60em;
            padding: 0;
            margin-bottom: -10px;
        }

        .titulo p.activi {
            text-align: center;
            font-size: 0.60em;
            padding: 0;
        }

        .titulo_derecha {
            position: absolute;
            top: 0;
            right: 0;
            width: 180px;
        }

        .titulo_derecha h2 {
            text-align: center;
            font-size: 0.85em;
            color: #c57a40;
            font-family: Calibri, sans-serif;
            border: solid 1px #c57a40;
            background: #c57a4079;
            margin-bottom: 2px;
            width: 180px;
        }

        .titulo_derecha .contenedor_info {
            padding-left: 5px;
            width: 175px;
            border: solid 1px #c57a40;
        }

        .titulo_derecha .contenedor_info p.info {
            font-size: 0.75em;
        }

        .logo {
            width: 130px;
            height: 100px;
            position: absolute;
            top: 0;
            left: 0;
        }

        .datos_factura {
            font-size: 0.75em;
            width: 100%;
            margin-bottom: 10px;
            margin-top: 30px;
        }

        .datos_factura .c1 {
            width: 10%;
        }

        .datos_factura .c2 {
            width: 7%;
        }

        .factura {
            border-collapse: collapse;
            position: relative;
            width: 100%;
            font-size: 0.7em;
        }

        .factura thead tr {
            background: #c57a40;
            color: white;
        }

        .factura thead tr th {
            font-size: 1.1em;
            text-align: center;
            font-weight: bold;
        }

        .factura tbody tr td {
            text-align: center;
        }

        .factura tbody tr:nth-child(1) td:nth-child(2) {
            text-align: left;
        }

        .factura thead tr th,
        .factura tbody tr td {
            padding: 5px;
        }


        .factura tbody tr.total td:first-child {
            text-align: right;
            padding-right: 15px;
        }

        .factura tbody tr.total_final td:nth-child(1) {
            text-align: right;
        }

        .factura tbody tr.total_final td {
            font-weight: bold;
            font-size: 1.1em;
        }

        .factura tbody tr.total_final {
            background: #c57a40;
            color: white;
        }

        .factura tbody tr.total_literal td:nth-child(3n) {
            text-align: right;
            padding-right: 15px;
        }

        .factura tbody tr.total_literal td:nth-child(4n) {
            text-align: left;
            padding-left: 15px;
        }

        .codigos {
            margin-top: 35px;
            width: 70%;
        }

        .codigos tbody tr td {
            font-size: 0.7em;
        }

        .codigos tbody tr td.c1 {
            width: 35%;
        }

        .codigos tbody tr td.c2 {
            width: 65%;
        }

        .codigos tbody tr td.qr {
            width: 30%;
        }

        .qr {
            width: 120px;
            height: 120px;
        }

        .qr img {
            width: 100%;
            height: 100%;
        }

        .info1 {
            margin-top: 20px;
            text-align: center;
            font-weight: bold;
            font-size: 0.6em;
        }

        .info2 {
            text-align: center;
            font-weight: bold;
            font-size: 0.5em;
        }
    </style>
</head>

<body>
    @inject('o_configuracion', 'App\Models\Configuracion')
    @php
        $configuracion = $o_configuracion->first();
    @endphp
    <img src="{{ $configuracion->path_image }}" class="logo" alt="">
    <div class="titulo">
        <p class="emp">{{ $configuracion->razon_social }}</p>
        <p class="dir">{{ $configuracion->dir }}</p>
        <p class="dir">{{ $configuracion->ciudad }}</p>
        <p class="activi">ACTIVIDAD ECONÓMICA: {{ $configuracion->actividad }}</p>
    </div>
    <div class="titulo_derecha">
        <h2>RECIBO</h2>
        <div class="contenedor_info">
            <p class="info"><strong>N° Recibo: </strong><span>{{ $caja->txt_nro }}</span></p>
        </div>
    </div>
    <table class="datos_factura">
        <tbody>
            <tr>
                <td class="c1"><strong>A favor de: </strong></td>
                @if ($caja->a_favor == 'OTRO')
                    <td>{{ $caja->nombre }}</td>
                @else
                    <td>{{ $caja->user->full_name }}</td>
                @endif
                <td class="c2"><strong>Fecha: </strong> </td>
                <td>{{ date('d-m-Y', strtotime($caja->fecha)) }}</td>
            </tr>
        </tbody>
    </table>

    <table class="factura">
        <thead>
            <tr>
                <th>N°</th>
                <th>Descripción</th>
                <th>Concepto</th>
                <th>Subtotal (Bs.)</th>
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            <tr>
                <td>{{ $cont }}</td>
                <td>{{ $caja->descripcion }}</td>
                <td>{{ $caja->concepto->nombre }}</td>
                <td>{{ $caja->monto }}</td>
            </tr>
            <tr class="total_final">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    TOTAL (Bs.)
                </td>
                <td>
                    {{ $caja->monto }}
                </td>
            </tr>
            <tr class="total_literal">
                <td colspan="4">
                    SON:
                    {{ $literal }}
                </td>
            </tr>
        </tbody>
    </table>
</body>

</html>
