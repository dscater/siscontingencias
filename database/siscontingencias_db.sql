-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 11-11-2024 a las 20:58:48
-- Versión del servidor: 8.0.30
-- Versión de PHP: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `siscontingencias_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actividades_contingencias`
--

CREATE TABLE `actividades_contingencias` (
  `id` bigint UNSIGNED NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `antes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `durante` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `despues` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `actividades_contingencias`
--

INSERT INTO `actividades_contingencias` (`id`, `titulo`, `antes`, `durante`, `despues`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(5, 'DENEGACIÓN DE SERVICIOS', 'TINCIDUNT ARCU NON SODALES NEQUE SODALES UT ETIAM SIT. PHASELLUS VESTIBULUM LOREM SED RISUS ULTRICIES. FACILISI ETIAM DIGNISSIM DIAM QUIS ENIM LOBORTIS SCELERISQUE FERMENTUM.', 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. MAGNA AC PLACERAT VESTIBULUM LECTUS MAURIS ULTRICES.', 'SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN. NISL TINCIDUNT EGET NULLAM NON NISI EST SIT. MAURIS CURSUS MATTIS MOLESTIE A IACULIS AT ERAT', '2023-11-16', '2023-11-16 16:34:11', '2023-11-16 16:35:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amenazas_seguridad`
--

CREATE TABLE `amenazas_seguridad` (
  `id` bigint UNSIGNED NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `consecuencias` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `amenazas_seguridad`
--

INSERT INTO `amenazas_seguridad` (`id`, `titulo`, `descripcion`, `consecuencias`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'FUGA DE INFORMACIÓN', 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. MAGNA AC PLACERAT VESTIBULUM LECTUS MAURIS ULTRICES.', '- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.', '2023-11-16', '2023-11-16 16:29:40', '2023-11-16 16:29:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ciudad` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `web` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `ciudad`, `dir`, `fono`, `web`, `actividad`, `correo`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'SISCONTINGENCIAS', 'SISCONTINGENCIAS', 'SISCONTINGENCIAS', 'LA PAZ', 'LOS OLIVOS', '222222', NULL, 'ACTIVIDAD', 'siscontingencias@gmail.com', 'logo.jpg', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controls`
--

CREATE TABLE `controls` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `asignados` int NOT NULL DEFAULT '0',
  `pendientes` int NOT NULL DEFAULT '0',
  `observados` int NOT NULL DEFAULT '0',
  `finalizados` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `controls`
--

INSERT INTO `controls` (`id`, `user_id`, `asignados`, `pendientes`, `observados`, `finalizados`, `created_at`, `updated_at`) VALUES
(1, 2, 3, 1, 1, 1, '2024-11-11 19:59:17', '2024-11-11 20:48:56'),
(2, 3, 2, 2, 0, 0, '2024-11-11 19:59:17', '2024-11-11 20:48:30');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envio_correos`
--

CREATE TABLE `envio_correos` (
  `id` bigint UNSIGNED NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `puerto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encriptado` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `envio_correos`
--

INSERT INTO `envio_correos` (`id`, `host`, `puerto`, `encriptado`, `email`, `nombre`, `password`, `driver`, `created_at`, `updated_at`) VALUES
(1, 'smtp.hostinger.com', '587', 'tls', 'mensaje@emsytsrl.com', 'SISCONTINGENCIAS', '1Uno2Dos3Tres-0', 'smtp', '2024-04-27 16:28:23', '2024-04-27 16:28:48');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` text COLLATE utf8mb4_unicode_ci,
  `datos_nuevo` text COLLATE utf8mb4_unicode_ci,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: FUNCIONARIO<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 1<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:01:49<br/>', NULL, 'USUARIOS', '2023-11-08', '10:01:49', '2023-11-08 14:01:49', '2023-11-08 14:01:49'),
(2, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: FUNCIONARIO<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 1<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:01:49<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: FUNCIONARIO<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 0<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:02:54<br/>', 'USUARIOS', '2023-11-08', '10:02:54', '2023-11-08 14:02:54', '2023-11-08 14:02:54'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: FUNCIONARIO<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 0<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:02:54<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: ADMINISTRADOR<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 0<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:02:58<br/>', 'USUARIOS', '2023-11-08', '10:02:58', '2023-11-08 14:02:58', '2023-11-08 14:02:58'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin MODIFICÓ UN USUARIO', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: ADMINISTRADOR<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 0<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:02:58<br/>', 'id: 2<br/>usuario: JPERES<br/>nombre: JUAN<br/>paterno: PERES<br/>materno: MAMANI<br/>ci: 1234<br/>ci_exp: LP<br/>dir: LOS OLIVOS<br/>correo: <br/>fono: 777777<br/>tipo: FUNCIONARIO<br/>foto: 1699452109_JPERES.jpg<br/>password: $2y$10$DVPM4sWlTtbQNeDi6Kh.6uuUxAnY6ovk4KUFPPZTqj8VzvJ.fvLjm<br/>acceso: 1<br/>fecha_registro: 2023-11-08<br/>created_at: 2023-11-08 10:01:49<br/>updated_at: 2023-11-08 10:03:03<br/>', 'USUARIOS', '2023-11-08', '10:03:03', '2023-11-08 14:03:03', '2023-11-08 14:03:03'),
(5, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN PLAN DE CONTINGENCIA', 'created_at: 2023-11-16 10:57:55<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: CONFIDENCIALIDAD<br/>updated_at: 2023-11-16 10:57:55<br/>', NULL, 'PLAN DE CONTINGENCIAS', '2023-11-16', '10:57:55', '2023-11-16 14:57:55', '2023-11-16 14:57:55'),
(6, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN PLAN DE CONTINGENCIA', 'created_at: 2023-11-16 11:08:19<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>fecha_registro: 2023-11-16<br/>id: 2<br/>titulo: INTEGRIDAD<br/>updated_at: 2023-11-16 11:08:19<br/>', NULL, 'PLAN DE CONTINGENCIAS', '2023-11-16', '11:08:19', '2023-11-16 15:08:19', '2023-11-16 15:08:19'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN PLAN DE CONTINGENCIA', 'created_at: 2023-11-16 10:57:55<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: CONFIDENCIALIDAD<br/>updated_at: 2023-11-16 10:57:55<br/>', 'created_at: 2023-11-16 10:57:55<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br />\r\nOTRO PARRAFO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: CONFIDENCIALIDAD<br/>updated_at: 2023-11-16 11:13:56<br/>', 'PLAN DE CONTINGENCIAS', '2023-11-16', '11:13:56', '2023-11-16 15:13:56', '2023-11-16 15:13:56'),
(8, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UN PLAN DE CONTINGENCIA', 'created_at: 2023-11-16 11:08:19<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>fecha_registro: 2023-11-16<br/>id: 2<br/>titulo: INTEGRIDAD<br/>updated_at: 2023-11-16 11:08:19<br/>', NULL, 'PLAN DE CONTINGENCIAS', '2023-11-16', '11:20:30', '2023-11-16 15:20:30', '2023-11-16 15:20:30'),
(9, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN ROL Y FUNCIÓN', 'created_at: 2023-11-16 11:42:26<br/>fecha_registro: 2023-11-16<br/>funciones_atribuciones: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>id: 1<br/>rol: NOMBRE ROL A<br/>titulo: INTEGRIDAD<br/>updated_at: 2023-11-16 11:42:26<br/>', NULL, 'ROLES Y FUNCIONES', '2023-11-16', '11:42:26', '2023-11-16 15:42:26', '2023-11-16 15:42:26'),
(10, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN ROL Y FUNCIÓN', 'created_at: 2023-11-16 11:59:52<br/>fecha_registro: 2023-11-16<br/>funciones_atribuciones: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>id: 2<br/>rol: NOMBRE ROL B<br/>titulo: SEGURIDAD<br/>updated_at: 2023-11-16 11:59:52<br/>', NULL, 'ROLES Y FUNCIONES', '2023-11-16', '11:59:52', '2023-11-16 15:59:52', '2023-11-16 15:59:52'),
(11, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA AMENAZA Y SEGURIDAD', 'consecuencias: - SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br/>created_at: 2023-11-16 12:13:07<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN<br/>updated_at: 2023-11-16 12:13:07<br/>', NULL, 'AMENAZAS Y SEGURIDAD', '2023-11-16', '12:13:07', '2023-11-16 16:13:07', '2023-11-16 16:13:07'),
(12, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN ROL Y FUNCIÓN', 'created_at: 2023-11-16 11:59:52<br/>fecha_registro: 2023-11-16<br/>funciones_atribuciones: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>id: 2<br/>rol: NOMBRE ROL B<br/>titulo: SEGURIDAD<br/>updated_at: 2023-11-16 11:59:52<br/>', 'created_at: 2023-11-16 11:59:52<br/>fecha_registro: 2023-11-16<br/>funciones_atribuciones: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br />\r\nNUEVO PARRAFO<br/>id: 2<br/>rol: NOMBRE ROL B<br/>titulo: SEGURIDAD<br/>updated_at: 2023-11-16 12:15:31<br/>', 'ROLES Y FUNCIONES', '2023-11-16', '12:15:31', '2023-11-16 16:15:31', '2023-11-16 16:15:31'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UN PLAN DE CONTINGENCIA', 'created_at: 2023-11-16 10:57:55<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br />\nOTRO PARRAFO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: CONFIDENCIALIDAD<br/>updated_at: 2023-11-16 11:13:56<br/>', 'created_at: 2023-11-16 10:57:55<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br />\r\nOTRO PARRAFO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: CONFIDENCIALIDAD<br/>updated_at: 2023-11-16 12:15:40<br/>', 'PLAN DE CONTINGENCIAS', '2023-11-16', '12:15:40', '2023-11-16 16:15:40', '2023-11-16 16:15:40'),
(14, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA AMENAZA Y SEGURIDAD', 'consecuencias: - SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br/>created_at: 2023-11-16 12:13:07<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN<br/>updated_at: 2023-11-16 12:13:07<br/>', 'consecuencias: - SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- OTRA LINEA<br/>created_at: 2023-11-16 12:13:07<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT. TEXTO AGREGADO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN MODIFICADO<br/>updated_at: 2023-11-16 12:19:37<br/>', 'AMENAZAS Y SEGURIDAD', '2023-11-16', '12:19:37', '2023-11-16 16:19:37', '2023-11-16 16:19:37'),
(15, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA AMENAZA Y SEGURIDAD', 'consecuencias: - SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- OTRA LINEA<br/>created_at: 2023-11-16 12:13:07<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT. TEXTO AGREGADO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN MODIFICADO<br/>updated_at: 2023-11-16 12:19:37<br/>', 'consecuencias: - SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- OTRA LINEA<br/>created_at: 2023-11-16 12:13:07<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT. <br />\r\nTEXTO AGREGADO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN MODIFICADO<br/>updated_at: 2023-11-16 12:19:46<br/>', 'AMENAZAS Y SEGURIDAD', '2023-11-16', '12:19:46', '2023-11-16 16:19:46', '2023-11-16 16:19:46'),
(16, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA AMENAZA Y SEGURIDAD', 'consecuencias: - SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- OTRA LINEA<br/>created_at: 2023-11-16 12:13:07<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT. <br />\r\nTEXTO AGREGADO<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN MODIFICADO<br/>updated_at: 2023-11-16 12:19:46<br/>', NULL, 'AMENAZAS Y SEGURIDAD', '2023-11-16', '12:20:23', '2023-11-16 16:20:23', '2023-11-16 16:20:23'),
(17, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA AMENAZA Y SEGURIDAD', 'consecuencias: - ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br />\r\n- ET NETUS ET MALESUADA FAMES AC TURPIS. SCELERISQUE IN DICTUM NON CONSECTETUR A ERAT NAM AT LECTUS.<br />\r\n- SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN.<br/>created_at: 2023-11-16 12:29:40<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. MAGNA AC PLACERAT VESTIBULUM LECTUS MAURIS ULTRICES.<br/>fecha_registro: 2023-11-16<br/>id: 1<br/>titulo: FUGA DE INFORMACIÓN<br/>updated_at: 2023-11-16 12:29:40<br/>', NULL, 'AMENAZAS Y SEGURIDAD', '2023-11-16', '12:29:40', '2023-11-16 16:29:40', '2023-11-16 16:29:40'),
(18, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ACTIVIDAD DE CONTINGENCIA', 'antes: DENEGACIÓN DE SERVICIOS<br/>created_at: 2023-11-16 12:34:11<br/>despues: DENEGACIÓN DE SERVICIOS<br/>durante: DENEGACIÓN DE SERVICIOS<br/>fecha_registro: 2023-11-16<br/>id: 5<br/>titulo: DENEGACIÓN DE SERVICIOS<br/>updated_at: 2023-11-16 12:34:11<br/>', NULL, 'ACTIVIDADES DE CONTINGENCIAS', '2023-11-16', '12:34:11', '2023-11-16 16:34:11', '2023-11-16 16:34:11'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ACTIVIDAD DE CONTINGENCIA', 'antes: DENEGACIÓN DE SERVICIOS<br/>created_at: 2023-11-16 12:34:11<br/>despues: DENEGACIÓN DE SERVICIOS<br/>durante: DENEGACIÓN DE SERVICIOS<br/>fecha_registro: 2023-11-16<br/>id: 5<br/>titulo: DENEGACIÓN DE SERVICIOS<br/>updated_at: 2023-11-16 12:34:11<br/>', 'antes: TINCIDUNT ARCU NON SODALES NEQUE SODALES UT ETIAM SIT. PHASELLUS VESTIBULUM LOREM SED RISUS ULTRICIES. FACILISI ETIAM DIGNISSIM DIAM QUIS ENIM LOBORTIS SCELERISQUE FERMENTUM.<br/>created_at: 2023-11-16 12:34:11<br/>despues: SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN. NISL TINCIDUNT EGET NULLAM NON NISI EST SIT. MAURIS CURSUS MATTIS MOLESTIE A IACULIS AT ERAT<br/>durante: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. MAGNA AC PLACERAT VESTIBULUM LECTUS MAURIS ULTRICES.<br/>fecha_registro: 2023-11-16<br/>id: 5<br/>titulo: DENEGACIÓN DE SERVICIOS<br/>updated_at: 2023-11-16 12:35:06<br/>', 'ACTIVIDADES DE CONTINGENCIAS', '2023-11-16', '12:35:06', '2023-11-16 16:35:06', '2023-11-16 16:35:06'),
(20, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UNA ACTIVIDAD DE CONTINGENCIA', 'antes: FAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS. <br />\r\nFAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS.<br/>created_at: 2023-11-16 12:35:48<br/>despues: SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN<br/>durante: TINCIDUNT ARCU NON SODALES NEQUE SODALES UT ETIAM SIT. PHASELLUS VESTIBULUM LOREM SED RISUS ULTRICIES. FACILISI ETIAM DIGNISSIM DIAM QUIS ENIM LOBORTIS SCELERISQUE FERMENTUM.<br/>fecha_registro: 2023-11-16<br/>id: 6<br/>titulo: CAÍDA DE SISTEMA POR AGOTAMIENTO DE RECURSOS<br/>updated_at: 2023-11-16 12:35:48<br/>', NULL, 'ACTIVIDADES DE CONTINGENCIAS', '2023-11-16', '12:35:48', '2023-11-16 16:35:48', '2023-11-16 16:35:48'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO  MODIFICÓ UNA ACTIVIDAD DE CONTINGENCIA', 'antes: FAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS. <br />\r\nFAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS.<br/>created_at: 2023-11-16 12:35:48<br/>despues: SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN<br/>durante: TINCIDUNT ARCU NON SODALES NEQUE SODALES UT ETIAM SIT. PHASELLUS VESTIBULUM LOREM SED RISUS ULTRICIES. FACILISI ETIAM DIGNISSIM DIAM QUIS ENIM LOBORTIS SCELERISQUE FERMENTUM.<br/>fecha_registro: 2023-11-16<br/>id: 6<br/>titulo: CAÍDA DE SISTEMA POR AGOTAMIENTO DE RECURSOS<br/>updated_at: 2023-11-16 12:35:48<br/>', 'antes: FAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS. <br />\r\nFAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS. MODIFICADO<br/>created_at: 2023-11-16 12:35:48<br/>despues: SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN<br />\r\nOTRA LINEA DESPUES<br/>durante: TINCIDUNT ARCU NON SODALES NEQUE SODALES UT ETIAM SIT. PHASELLUS VESTIBULUM LOREM SED RISUS ULTRICIES. FACILISI ETIAM DIGNISSIM DIAM QUIS ENIM LOBORTIS SCELERISQUE FERMENTUM.<br />\r\nOTRA LINEA<br/>fecha_registro: 2023-11-16<br/>id: 6<br/>titulo: CAÍDA DE SISTEMA POR AGOTAMIENTO DE RECURSOS<br/>updated_at: 2023-11-16 12:36:06<br/>', 'ACTIVIDADES DE CONTINGENCIAS', '2023-11-16', '12:36:06', '2023-11-16 16:36:06', '2023-11-16 16:36:06'),
(22, 1, 'ELIMINACIÓN', 'EL USUARIO  ELIMINÓ UNA ACTIVIDAD DE CONTINGENCIA', 'antes: FAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS. <br />\r\nFAMES AC TURPIS EGESTAS SED TEMPUS URNA ET PHARETRA PHARETRA. AMET PORTTITOR EGET DOLOR MORBI NON ARCU RISUS. MODIFICADO<br/>created_at: 2023-11-16 12:35:48<br/>despues: SEM VIVERRA ALIQUET EGET SIT AMET TELLUS CRAS. PURUS GRAVIDA QUIS BLANDIT TURPIS CURSUS IN<br />\r\nOTRA LINEA DESPUES<br/>durante: TINCIDUNT ARCU NON SODALES NEQUE SODALES UT ETIAM SIT. PHASELLUS VESTIBULUM LOREM SED RISUS ULTRICIES. FACILISI ETIAM DIGNISSIM DIAM QUIS ENIM LOBORTIS SCELERISQUE FERMENTUM.<br />\r\nOTRA LINEA<br/>fecha_registro: 2023-11-16<br/>id: 6<br/>titulo: CAÍDA DE SISTEMA POR AGOTAMIENTO DE RECURSOS<br/>updated_at: 2023-11-16 12:36:06<br/>', NULL, 'ACTIVIDADES DE CONTINGENCIAS', '2023-11-16', '12:36:14', '2023-11-16 16:36:14', '2023-11-16 16:36:14'),
(23, 1, 'CREACIÓN', 'EL USUARIO  REGISTRO UN PLAN DE CONTINGENCIA', 'created_at: 2023-11-17 10:31:21<br/>descripcion: LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM.<br/>fecha_registro: 2023-11-17<br/>id: 3<br/>titulo: INTEGRIDAD<br/>updated_at: 2023-11-17 10:31:21<br/>', NULL, 'PLAN DE CONTINGENCIAS', '2023-11-17', '10:31:21', '2023-11-17 14:31:21', '2023-11-17 14:31:21'),
(24, 1, 'CREACIÓN', 'EL USUARIO REGISTRO UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:42:25<br/>user_id: 2<br/>', NULL, 'PLAN DE CALIDADS', '2024-05-01', '12:42:25', '2024-05-01 16:42:25', '2024-05-01 16:42:25'),
(25, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:42:25<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:44:28<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:44:28', '2024-05-01 16:44:28', '2024-05-01 16:44:28'),
(26, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:44:28<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:45:15<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:45:15', '2024-05-01 16:45:15', '2024-05-01 16:45:15'),
(27, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:45:15<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:48:36<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:48:36', '2024-05-01 16:48:36', '2024-05-01 16:48:36'),
(28, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:48:36<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:49:03<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:49:03', '2024-05-01 16:49:03', '2024-05-01 16:49:03'),
(29, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:49:03<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:50:28<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:50:28', '2024-05-01 16:50:28', '2024-05-01 16:50:28'),
(30, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:50:28<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:51:47<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:51:47', '2024-05-01 16:51:47', '2024-05-01 16:51:47'),
(31, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:51:47<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:52:16<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:52:16', '2024-05-01 16:52:16', '2024-05-01 16:52:16'),
(32, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:52:16<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:53:38<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:53:38', '2024-05-01 16:53:38', '2024-05-01 16:53:38'),
(33, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:53:38<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:56:28<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:56:28', '2024-05-01 16:56:28', '2024-05-01 16:56:28'),
(34, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:56:28<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:57:28<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:57:28', '2024-05-01 16:57:28', '2024-05-01 16:57:28'),
(35, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:57:28<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:58:14<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:58:14', '2024-05-01 16:58:14', '2024-05-01 16:58:14'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:58:14<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:59:08<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:59:08', '2024-05-01 16:59:08', '2024-05-01 16:59:08'),
(37, 1, 'MODIFICACIÓN', 'EL USUARIO MODIFICÓ UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:59:08<br/>user_id: 2<br/>', 'actividad: ACTIVIDAD #1<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-05-01 12:42:25<br/>fecha_registro: 2024-05-01<br/>id: 2<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO 1<br/>plan_contingencia_id: 1<br/>registros: REGISTROS ACTIVIDAD #1<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 12:59:15<br/>user_id: 2<br/>', 'PLAN DE CALIDADS', '2024-05-01', '12:59:15', '2024-05-01 16:59:15', '2024-05-01 16:59:15'),
(38, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'acceso: 1<br/>ci: 2222<br/>ci_exp: LP<br/>correo: <br/>created_at: 2024-05-01 15:15:47<br/>dir: LOS OLIVOS<br/>fecha_registro: 2024-05-01<br/>fono: 77777777<br/>foto: default.png<br/>id: 3<br/>materno: <br/>nombre: MARCOS<br/>password: $2y$10$xgTLYejp0LWUIjqcg.CZj.Gvl9NMfaAZ4MahESZhHvMtULZhuV/iq<br/>paterno: MAMANI<br/>tipo: FUNCIONARIO<br/>updated_at: 2024-05-01 15:15:47<br/>usuario: MMAMANI<br/>', NULL, 'USUARIOS', '2024-05-01', '15:15:48', '2024-05-01 19:15:48', '2024-05-01 19:15:48'),
(39, 1, 'CREACIÓN', 'EL USUARIO REGISTRO UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #2<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: 1<br/>created_at: 2024-05-01 15:34:25<br/>fecha_registro: 2024-05-01<br/>id: 3<br/>norma: AMENAZAS Y SEGURDAD<br/>objetivo: OBJETIVO<br/>plan_contingencia_id: <br/>registros: REGISTROS<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 15:34:25<br/>user_id: 2<br/>', NULL, 'PLAN DE CALIDADS', '2024-05-01', '15:34:25', '2024-05-01 19:34:25', '2024-05-01 19:34:25'),
(40, 1, 'CREACIÓN', 'EL USUARIO REGISTRO UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #3<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: 1<br/>created_at: 2024-05-01 15:34:51<br/>fecha_registro: 2024-05-01<br/>id: 4<br/>norma: AMENAZAS Y SEGURDAD<br/>objetivo: OBJ- 3<br/>plan_contingencia_id: <br/>registros: REGISTROS<br/>rol_funcion_id: <br/>updated_at: 2024-05-01 15:34:51<br/>user_id: 3<br/>', NULL, 'PLAN DE CALIDADS', '2024-05-01', '15:34:51', '2024-05-01 19:34:51', '2024-05-01 19:34:51'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', 'acceso: 1<br/>ci: 3333<br/>ci_exp: LP<br/>correo: <br/>created_at: 2024-11-11 15:37:59<br/>dir: ZONA LOS OLIVOS<br/>fecha_registro: 2024-11-11<br/>fono: 7777777<br/>foto: default.png<br/>id: 4<br/>materno: MAMANI<br/>nombre: CARLOS<br/>password: $2y$10$ggFFy/G.d4z2WnAVX2HIf.AK3UzGzSSp0aFx3DB3NxYdYQDn0OKuG<br/>paterno: CASTRO<br/>tipo: SUPERVISOR<br/>updated_at: 2024-11-11 15:37:59<br/>usuario: CCASTRO<br/>', NULL, 'USUARIOS', '2024-11-11', '15:37:59', '2024-11-11 19:37:59', '2024-11-11 19:37:59'),
(42, 1, 'CREACIÓN', 'EL USUARIO REGISTRO UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD #2<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: <br/>created_at: 2024-11-11 16:48:30<br/>descripcion: <br/>estado: <br/>fecha_registro: 2024-11-11<br/>id: 7<br/>norma: PLAN DE CONTIGENCIAS<br/>objetivo: OBJETIVO #2<br/>plan_contingencia_id: 3<br/>registros: REGISTROS<br/>rol_funcion_id: <br/>updated_at: 2024-11-11 16:48:30<br/>user_id: 3<br/>', NULL, 'PLAN DE CALIDADS', '2024-11-11', '16:48:30', '2024-11-11 20:48:30', '2024-11-11 20:48:30'),
(43, 1, 'CREACIÓN', 'EL USUARIO REGISTRO UN PLAN DE CALIDAD', 'actividad: ACTIVIDAD TRES<br/>actividad_contingencia_id: <br/>amenaza_seguridad_id: 1<br/>created_at: 2024-11-11 16:48:56<br/>descripcion: <br/>estado: <br/>fecha_registro: 2024-11-11<br/>id: 8<br/>norma: AMENAZAS Y SEGURDAD<br/>objetivo: OBJETIVO TRES<br/>plan_contingencia_id: <br/>registros: REGISTRO DEL PLAN TRES<br/>rol_funcion_id: <br/>updated_at: 2024-11-11 16:48:56<br/>user_id: 2<br/>', NULL, 'PLAN DE CALIDADS', '2024-11-11', '16:48:56', '2024-11-11 20:48:56', '2024-11-11 20:48:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000002_create_users_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2022_10_13_132625_create_configuracions_table', 1),
(4, '2023_08_26_190801_create_historial_accions_table', 1),
(5, '2023_11_16_101132_create_plan_contingencias_table', 2),
(6, '2023_11_16_101312_create_roles_funciones_table', 2),
(7, '2023_11_16_101428_create_amenazas_seguridad_table', 2),
(8, '2023_11_16_101528_create_actividades_contingencias_table', 2),
(9, '2024_05_01_110726_create_plan_calidads_table', 3),
(10, '2024_05_01_110750_create_plan_archivos_table', 3),
(11, '2024_05_01_111045_create_envio_correos_table', 3),
(12, '2024_05_01_153736_create_recuperacions_table', 4),
(13, '2024_11_11_150859_create_controls_table', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_archivos`
--

CREATE TABLE `plan_archivos` (
  `id` bigint UNSIGNED NOT NULL,
  `plan_calidad_id` bigint UNSIGNED NOT NULL,
  `archivo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ext` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_archivos`
--

INSERT INTO `plan_archivos` (`id`, `plan_calidad_id`, `archivo`, `ext`, `created_at`, `updated_at`) VALUES
(1, 2, '1714582228_02.pdf', 'pdf', '2024-05-01 16:50:28', '2024-05-01 16:50:28'),
(2, 2, '1714582228_12.docx', 'docx', '2024-05-01 16:50:28', '2024-05-01 16:50:28'),
(3, 2, '1714582307_02.png', 'png', '2024-05-01 16:51:47', '2024-05-01 16:51:47'),
(12, 4, '1714592091_04.png', 'png', '2024-05-01 19:34:51', '2024-05-01 19:34:51'),
(13, 4, '1714592091_14.pdf', 'pdf', '2024-05-01 19:34:51', '2024-05-01 19:34:51'),
(14, 4, '1714592091_24.docx', 'docx', '2024-05-01 19:34:51', '2024-05-01 19:34:51');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_calidads`
--

CREATE TABLE `plan_calidads` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `actividad` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `norma` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_contingencia_id` bigint UNSIGNED DEFAULT NULL,
  `rol_funcion_id` bigint UNSIGNED DEFAULT NULL,
  `amenaza_seguridad_id` bigint UNSIGNED DEFAULT NULL,
  `actividad_contingencia_id` bigint UNSIGNED DEFAULT NULL,
  `objetivo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `registros` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'PENDIENTE',
  `descripcion` text COLLATE utf8mb4_unicode_ci,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_calidads`
--

INSERT INTO `plan_calidads` (`id`, `user_id`, `actividad`, `norma`, `plan_contingencia_id`, `rol_funcion_id`, `amenaza_seguridad_id`, `actividad_contingencia_id`, `objetivo`, `registros`, `estado`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(2, 2, 'ACTIVIDAD #1', 'PLAN DE CONTIGENCIAS', 1, NULL, NULL, NULL, 'OBJETIVO 1', 'REGISTROS ACTIVIDAD #1', 'OBSERVADO', 'DESC. OBSERVADO', '2024-05-01', '2024-05-01 16:42:25', '2024-11-11 20:46:35'),
(3, 2, 'ACTIVIDAD #2', 'AMENAZAS Y SEGURDAD', NULL, NULL, 1, NULL, 'OBJETIVO', 'REGISTROS', 'FINALIZADO', 'DESC. FINALIZADO', '2024-05-01', '2024-05-01 19:34:25', '2024-11-11 20:47:08'),
(4, 3, 'ACTIVIDAD #3', 'AMENAZAS Y SEGURDAD', NULL, NULL, 1, NULL, 'OBJ- 3', 'REGISTROS', 'PENDIENTE', NULL, '2024-05-01', '2024-05-01 19:34:51', '2024-05-01 19:34:51'),
(7, 3, 'ACTIVIDAD #2', 'PLAN DE CONTIGENCIAS', 3, NULL, NULL, NULL, 'OBJETIVO #2', 'REGISTROS', 'PENDIENTE', NULL, '2024-11-11', '2024-11-11 20:48:30', '2024-11-11 20:48:30'),
(8, 2, 'ACTIVIDAD TRES', 'AMENAZAS Y SEGURDAD', NULL, NULL, 1, NULL, 'OBJETIVO TRES', 'REGISTRO DEL PLAN TRES', 'PENDIENTE', NULL, '2024-11-11', '2024-11-11 20:48:56', '2024-11-11 20:48:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_contingencias`
--

CREATE TABLE `plan_contingencias` (
  `id` bigint UNSIGNED NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `plan_contingencias`
--

INSERT INTO `plan_contingencias` (`id`, `titulo`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'CONFIDENCIALIDAD', 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br />\r\nOTRO PARRAFO', '2023-11-16', '2023-11-16 14:57:55', '2023-11-16 16:15:40'),
(3, 'INTEGRIDAD', 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM.', '2023-11-17', '2023-11-17 14:31:21', '2023-11-17 14:31:21');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recuperacions`
--

CREATE TABLE `recuperacions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cod` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `recuperado` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `recuperacions`
--

INSERT INTO `recuperacions` (`id`, `user_id`, `email`, `cod`, `recuperado`, `created_at`, `updated_at`) VALUES
(1, NULL, 'victorgonzalo.as@gmail.com', 'Q3QIAV', 1, '2024-05-13 16:30:33', '2024-05-13 16:33:31'),
(3, NULL, 'victorgonzalo.as@gmail.com', 'G4CKUX', 1, '2024-06-26 14:11:58', '2024-06-26 14:12:49');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_funciones`
--

CREATE TABLE `roles_funciones` (
  `id` bigint UNSIGNED NOT NULL,
  `titulo` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `funciones_atribuciones` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles_funciones`
--

INSERT INTO `roles_funciones` (`id`, `titulo`, `rol`, `funciones_atribuciones`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'INTEGRIDAD', 'NOMBRE ROL A', 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.', '2023-11-16', '2023-11-16 15:42:26', '2023-11-16 15:42:26'),
(2, 'SEGURIDAD', 'NOMBRE ROL B', 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT, SED DO EIUSMOD TEMPOR INCIDIDUNT UT LABORE ET DOLORE MAGNA ALIQUA. UT ENIM AD MINIM VENIAM, QUIS NOSTRUD EXERCITATION ULLAMCO LABORIS NISI UT ALIQUIP EX EA COMMODO CONSEQUAT.<br />\r\nNUEVO PARRAFO', '2023-11-16', '2023-11-16 15:59:52', '2023-11-16 16:15:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `tipo`, `foto`, `password`, `acceso`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', NULL, '0', '', '', NULL, '', 'ADMINISTRADOR', NULL, '$2y$10$RrCZZySOwPej2gMFWsrjMe6dLzfaL5Q88h4J75I1FesEBRNPwq1x.', 1, '2023-11-01', NULL, NULL),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '1234', 'LP', 'LOS OLIVOS', NULL, '777777', 'FUNCIONARIO', '1699452109_JPERES.jpg', '$2y$10$JJG8Z10ezDVHqVBX5AuW1eAXR.Hlp2ULIQmG9zDvbybbRZeeds/eW', 1, '2023-11-08', '2023-11-08 14:01:49', '2024-06-26 14:12:49'),
(3, 'MMAMANI', 'MARCOS', 'MAMANI', '', '2222', 'LP', 'LOS OLIVOS', NULL, '77777777', 'FUNCIONARIO', 'default.png', '$2y$10$UQeNqANB5TpP7SsRyjMzD.Ip3uPZDGZZaXKBdJJCEojQzvNCdZmu2', 1, '2024-05-01', '2024-05-01 19:15:47', '2024-05-13 16:33:31'),
(4, 'CCASTRO', 'CARLOS', 'CASTRO', 'MAMANI', '3333', 'LP', 'ZONA LOS OLIVOS', NULL, '7777777', 'SUPERVISOR', 'default.png', '$2y$10$ggFFy/G.d4z2WnAVX2HIf.AK3UzGzSSp0aFx3DB3NxYdYQDn0OKuG', 1, '2024-11-11', '2024-11-11 19:37:59', '2024-11-11 19:37:59');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actividades_contingencias`
--
ALTER TABLE `actividades_contingencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `amenazas_seguridad`
--
ALTER TABLE `amenazas_seguridad`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `controls`
--
ALTER TABLE `controls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `controls_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `envio_correos`
--
ALTER TABLE `envio_correos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `plan_archivos`
--
ALTER TABLE `plan_archivos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `plan_calidads`
--
ALTER TABLE `plan_calidads`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `plan_contingencias`
--
ALTER TABLE `plan_contingencias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recuperacions`
--
ALTER TABLE `recuperacions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles_funciones`
--
ALTER TABLE `roles_funciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_usuario_unique` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actividades_contingencias`
--
ALTER TABLE `actividades_contingencias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `amenazas_seguridad`
--
ALTER TABLE `amenazas_seguridad`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `controls`
--
ALTER TABLE `controls`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `envio_correos`
--
ALTER TABLE `envio_correos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan_archivos`
--
ALTER TABLE `plan_archivos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `plan_calidads`
--
ALTER TABLE `plan_calidads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `plan_contingencias`
--
ALTER TABLE `plan_contingencias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `recuperacions`
--
ALTER TABLE `recuperacions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles_funciones`
--
ALTER TABLE `roles_funciones`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `controls`
--
ALTER TABLE `controls`
  ADD CONSTRAINT `controls_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
