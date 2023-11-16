import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

export default new Router({
    base: "/" + app_base,
    routes: [
        // INICIO
        {
            path: "/",
            name: "inicio",
            component: require("./components/Inicio.vue").default,
        },

        // LOGIN
        {
            path: "/login",
            name: "login",
            component: require("./Auth.vue").default,
        },

        // Usuarios
        {
            path: "/usuarios/perfil/:id",
            name: "usuarios.perfil",
            component: require("./components/modulos/usuarios/perfil.vue")
                .default,
            props: true,
        },
        {
            path: "/usuarios",
            name: "usuarios.index",
            component: require("./components/modulos/usuarios/index.vue")
                .default,
        },

        // Plan Contingencias
        {
            path: "/plan_contingencias",
            name: "plan_contingencias.index",
            component:
                require("./components/modulos/plan_contingencias/index.vue")
                    .default,
        },

        // roles_funciones
        {
            path: "/roles_funciones",
            name: "roles_funciones.index",
            component: require("./components/modulos/roles_funciones/index.vue")
                .default,
        },

        // amenazas_seguridad
        {
            path: "/amenazas_seguridad",
            name: "amenazas_seguridad.index",
            component:
                require("./components/modulos/amenazas_seguridad/index.vue")
                    .default,
        },

        // actividades_contingencias
        {
            path: "/actividades_contingencias",
            name: "actividades_contingencias.index",
            component:
                require("./components/modulos/actividades_contingencias/index.vue")
                    .default,
        },

        // Configuración
        {
            path: "/configuracion",
            name: "configuracion",
            component: require("./components/modulos/configuracion/index.vue")
                .default,
            props: true,
        },

        // Reportes
        {
            path: "/reportes/usuarios",
            name: "reportes.usuarios",
            component: require("./components/modulos/reportes/usuarios.vue")
                .default,
            props: true,
        },

        // PÁGINA NO ENCONTRADA
        {
            path: "*",
            component: require("./components/modulos/errors/404.vue").default,
        },
    ],
    mode: "history",
    linkActiveClass: "active open",
});
