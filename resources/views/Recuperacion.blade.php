@inject('configuracion', 'App\Models\Configuracion')
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ $configuracion->first()->alias }}</title>
    <style>
        #app {
            background-color: none;
            background-image: url("/imgs/fondo_login.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }
    </style>

    <link rel="stylesheet" href="{{ mix('css/app.css') }}">
    <link rel="stylesheet" href="{{ mix('css/plantilla.css') }}">
    <script>
        var main_url = "{{ url('') }}";
        var app_base = "";
    </script>
</head>

<body class="sidebar-mini layout-fixed control-sidebar-slide-open layout-navbar-fixed text-sm">
    <div id="app">
        <Recuperacion ruta="{{ route('base_path') }}" logo="{{ asset('imgs/' . $configuracion->first()->logo) }}"
            empresa="{{ $configuracion->first()->razon_social }}" configuracion="{{ $configuracion->first() }}"
            url_login="{{ url('/administracion') }}" recuperacion="{{ $recuperacion }}">
        </Recuperacion>
    </div>
    <script src="{{ asset('js/jquery.js') }}"></script>
    <script src="{{ mix('js/app.js') }}"></script>
    <script src="{{ mix('js/plantilla.js') }}"></script>
    <script>
        $(document).ready(function() {
            $(document).on("click", "aside nav ul li a", function() {
                if ($("body").hasClass("sidebar-open") && !$(this).parent().hasClass("menu")) {
                    $("body").addClass("sidebar-collapse");
                    $("body").addClass("sidebar-close");
                    $("body").removeClass("sidebar-open");
                }
            });
        });
    </script>
</body>

</html>
