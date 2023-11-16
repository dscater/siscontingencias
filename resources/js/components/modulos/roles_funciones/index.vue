<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Roles y Funciones</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <button
                            v-if="permisos.includes('roles_funciones.create')"
                            class="btn btn-danger btn-flat btn-block"
                            @click="
                                abreModal('nuevo');
                                limpiaRolFuncion();
                            "
                        >
                            <i class="fa fa-plus"></i>
                            Nuevo
                        </button>
                    </div>
                </div>
                <div class="row mb-2 mt-2">
                    <b-col lg="10" class="my-1">
                        <b-form-group
                            label="Buscar"
                            label-for="filter-input"
                            label-cols-sm="3"
                            label-align-sm="right"
                            label-size="sm"
                            class="mb-0"
                        >
                            <b-input-group size="sm">
                                <b-form-input
                                    id="filter-input"
                                    v-model="search"
                                    type="search"
                                    placeholder="Buscar"
                                    @keyup="buscarRegistros"
                                ></b-form-input>

                                <b-input-group-append>
                                    <b-button
                                        variant="danger"
                                        :disabled="!search"
                                        @click="
                                            search = '';
                                            buscarRegistros();
                                        "
                                        >Borrar</b-button
                                    >
                                </b-input-group-append>
                            </b-input-group>
                        </b-form-group>
                    </b-col>
                </div>

                <b-skeleton-wrapper :loading="loading">
                    <template #loading>
                        <b-row>
                            <b-col cols="12">
                                <b-skeleton-img
                                    no-aspect
                                    height="110px"
                                ></b-skeleton-img>
                            </b-col>
                        </b-row>
                        <b-row class="mt-4 pb-5">
                            <b-col cols="12">
                                <b-skeleton-img
                                    no-aspect
                                    height="110px"
                                ></b-skeleton-img>
                            </b-col>
                        </b-row>
                        <b-row class="mt-4 pb-5">
                            <b-col cols="12">
                                <b-skeleton-img
                                    no-aspect
                                    height="110px"
                                ></b-skeleton-img>
                            </b-col>
                        </b-row>
                    </template>
                    <div class="row" v-if="totalRows > 0">
                        <div class="col-md-12" v-for="item in listRegistros">
                            <div class="card border-0">
                                <div
                                    class="card-header bg-dark font-weight-bold"
                                >
                                    {{ item.titulo }}
                                </div>
                                <div
                                    class="card-body text-xs mb-0 p-0 border-0"
                                >
                                    <div class="row w-100 m-0">
                                        <div
                                            class="col-md-4 border border-gray p-0"
                                        >
                                            <div class="row m-0">
                                                <div
                                                    class="col-md-12 p-2 border-bottom border-gray"
                                                >
                                                    <h4
                                                        class="text-md w-100 text-center"
                                                    >
                                                        Roles
                                                    </h4>
                                                </div>
                                                <div
                                                    class="col-md-12 p-4"
                                                    v-html="item.rol"
                                                ></div>
                                            </div>
                                        </div>
                                        <div
                                            class="col-md-8 border border-gray p-0"
                                        >
                                            <div class="row m-0">
                                                <div
                                                    class="col-md-12 p-2 border-bottom border-gray"
                                                >
                                                    <h4
                                                        class="text-md w-100 text-center"
                                                    >
                                                        Funciones y Atribuciones
                                                        Específicas
                                                    </h4>
                                                </div>
                                                <div
                                                    class="col-md-12 p-4"
                                                    v-html="
                                                        item.funciones_atribuciones
                                                    "
                                                ></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div
                                    v-if="
                                        permisos.includes(
                                            'roles_funciones.edit'
                                        ) ||
                                        permisos.includes(
                                            'roles_funciones.destroy'
                                        )
                                    "
                                    class="card-footer d-flex justify-content-end"
                                >
                                    <button
                                        type="button"
                                        class="m-1 btn btn-warning"
                                        @click="editarRegistro(item)"
                                    >
                                        <i class="fa fa-edit"></i>
                                    </button>
                                    <button
                                        type="button"
                                        class="m-1 btn btn-danger"
                                        @click="
                                            eliminaRolFuncion(
                                                item.id,
                                                `<h4>${item.titulo}</h4>`
                                            )
                                        "
                                    >
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" v-else>
                        <div class="col-md-12">
                            <h4 class="w-100 text-center text-gray">
                                NO SE ENCONTRARON REGISTROS
                            </h4>
                        </div>
                    </div>
                </b-skeleton-wrapper>

                <div class="row" v-if="totalRows > 0">
                    <b-col
                        sm="6"
                        md="2"
                        class="my-1 ml-auto mr-auto"
                        v-if="per_page"
                    >
                        <b-pagination
                            v-model="currentPage"
                            :total-rows="totalRows"
                            :per-page="per_page"
                            align="left"
                        ></b-pagination>
                    </b-col>
                </div>
            </div>
        </section>
        <Nuevo
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :rol_funcion="oRolFuncion"
            @close="muestra_modal = false"
            @envioModal="getRolFuncions"
        ></Nuevo>
    </div>
</template>

<script>
import Nuevo from "./Nuevo.vue";
export default {
    components: {
        Nuevo,
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            permisos:
                typeof localStorage.getItem("permisos") == "string"
                    ? JSON.parse(localStorage.getItem("permisos"))
                    : JSON.parse(localStorage.getItem("permisos")),
            search: "",
            listRegistros: [],
            loading: false,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            oRolFuncion: {
                id: 0,
                titulo: "",
                rol: "",
                funciones_atribuciones: "",
            },
            currentPage: 1,
            per_page: 10,
            totalRows: 10,
            filter: null,
            setTimeBuscar: null,
        };
    },
    watch: {
        currentPage(newVal) {
            this.getRolFuncions(newVal);
        },
    },
    mounted() {
        this.loadingWindow.close();
        this.getRolFuncions();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.oRolFuncion.id = item.id;
            this.oRolFuncion.titulo = item.titulo
                ? this.reemplazaBr(item.titulo)
                : "";
            this.oRolFuncion.rol = item.rol ? this.reemplazaBr(item.rol) : "";
            this.oRolFuncion.funciones_atribuciones =
                item.funciones_atribuciones
                    ? this.reemplazaBr(item.funciones_atribuciones)
                    : "";
            this.modal_accion = "edit";
            this.muestra_modal = true;
        },
        // buscar registros
        buscarRegistros() {
            this.loading = true;
            clearInterval(this.setTimeBuscar);
            this.setTimeBuscar = setTimeout(() => {
                this.getRolFuncions();
            }, 400);
        },

        // Listar RolFuncions
        getRolFuncions(page = 1) {
            this.loading = true;
            this.muestra_modal = false;
            let url = main_url + "/admin/roles_funciones";
            if (this.pagina != 0) {
                url += "?page=" + this.currentPage;
            }
            axios
                .get(url, {
                    params: { per_page: page, texto: this.search },
                })
                .then((res) => {
                    this.listRegistros = res.data.roles_funciones.data;
                    this.per_page = res.data.roles_funciones.per_page;
                    this.totalRows = res.data.roles_funciones.total;
                    this.loading = false;
                });
        },
        eliminaRolFuncion(id, descripcion) {
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${descripcion}</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#c82333",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post(main_url + "/admin/roles_funciones/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getRolFuncions();
                            this.filter = "";
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
                            if (error.response) {
                                if (error.response.status === 422) {
                                    this.errors = error.response.data.errors;
                                }
                                if (
                                    error.response.status === 420 ||
                                    error.response.status === 419 ||
                                    error.response.status === 401
                                ) {
                                    window.location = "/";
                                }
                                if (error.response.status === 500) {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Error",
                                        html: error.response.data.message,
                                        showConfirmButton: false,
                                        timer: 2000,
                                    });
                                }
                            }
                        });
                }
            });
        },
        abreModal(tipo_accion = "nuevo", rol_funcion = null) {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
            if (rol_funcion) {
                this.oRolFuncion = rol_funcion;
            }
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        limpiaRolFuncion() {
            this.oRolFuncion.titulo = "";
            this.oRolFuncion.rol = "";
            this.oRolFuncion.funciones_atribuciones = "";
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
    },
};
</script>

<style></style>
