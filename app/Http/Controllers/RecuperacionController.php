<?php

namespace App\Http\Controllers;

use App\Models\Recuperacion;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;

class RecuperacionController extends Controller
{
    public function olvide_mi_contrasenia()
    {
        return view("FormRecuperacion");
    }

    public function envia_correo_recuperacion(Request $request)
    {
        $validacion = [
            "email" => "required|email",
        ];

        $mensajes = [
            "email.required" => "Debes ingresar un correo",
            "email.email" => "Debes ingresar un correo valido",
        ];

        $request->validate($validacion, $mensajes);

        DB::beginTransaction();
        try {

            do {
                $nuevo_codigo = self::generarCodigoVerificacion();
                $existe = Recuperacion::where("cod", $nuevo_codigo)->get()->first();
            } while ($existe);

            $recuperacion = Recuperacion::create([
                "email" => trim($request->email),
                "cod" => $nuevo_codigo,
            ]);

            Log::debug($nuevo_codigo);

            $mensaje = 'Tú codigo de verificación es <b>' . $nuevo_codigo . '</b>';
            $mensaje .= '<br/>Ingresa este código y tu número de C.I. en el formulario de recuperación.';
            $mensaje .= '<br/>Haz click en este <a href="' . route('recuperacion', $recuperacion->id) . '">enlace</a> para ir al formulario para recuperar tu contraseña';
            if (EnvioCorreoController::mensajeRecuperacion(trim($request->email), $mensaje)) {
                DB::commit();
                return response()->JSON([
                    'sw' => true,
                    'message' => 'Te envíamos un correo, con un código de verificación para que puedas continuar con la recuperación de tu contraseña',
                ], 200);
            }

            throw new Exception("Ocurrio un problema al intentar realizar el envío. Por favor intente mas tarde");
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public static function generarCodigoVerificacion($longitud = 6)
    {
        $caracteres = '0123456789ABCDEFGHIJKLNMOPQRSTUVWXYZ'; // Caracteres que se pueden usar en el código de verificación
        $longitudCaracteres = strlen($caracteres);
        $codigo = '';

        for ($i = 0; $i < $longitud; $i++) {
            $codigo .= $caracteres[rand(0, $longitudCaracteres - 1)];
        }

        return mb_strtoupper($codigo);
    }

    public function recuperacion(Recuperacion $recuperacion)
    {
        return view("Recuperacion", compact("recuperacion"));
    }

    public function registro_recuperacion(Recuperacion $recuperacion, Request $request)
    {
        if ($recuperacion->recuperado != 0) {
            throw new Exception("Este link de recuperación ya fue usado. Vuelva a solicitar una nueva recuperación");
        }

        $request->validate(
            [
                'cod' => 'required',
                'ci' => 'required',
                'password' => 'required|string|min:8|confirmed'
            ],
            [
                "cod.required" => "Este campo es obligatorio",
                "ci.required" => "Este campo es obligatorio",
                "password.required" => "Este campo es obligatorio",
                "password.min" => "Debes ingresar como minimo 8 caracteres",
            ]
        );

        DB::beginTransaction();
        try {
            // codigo igual
            if (trim(mb_strtoupper($request->cod)) != $recuperacion->cod) {
                throw new Exception("El código que ingresaste no es valido");
            }

            $existe_user = User::where("ci", trim($request->ci))->get()->first();
            if (!$existe_user) {
                throw new Exception("No se encontró ningún registro con ese número de C.I. Asegurate de que solo estas ingresando el número");
            }

            $existe_user->password = Hash::make($request->password);
            $existe_user->save();

            $recuperacion->recuperado = 1;
            $recuperacion->save();
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'Contraseña actualizada correctamente',
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
