<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Plan de Calidad</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            v-if="
                                                permisos.includes(
                                                    'plan_calidads.create'
                                                )
                                            "
                                            class="btn btn-danger btn-flat btn-block"
                                            @click="
                                                abreModal('nuevo');
                                                limpiaPlanCalidad();
                                            "
                                        >
                                            <i class="fa fa-plus"></i>
                                            Nuevo
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
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
                                                    v-model="filter"
                                                    type="search"
                                                    placeholder="Buscar"
                                                ></b-form-input>

                                                <b-input-group-append>
                                                    <b-button
                                                        variant="danger"
                                                        :disabled="!filter"
                                                        @click="filter = ''"
                                                        >Borrar</b-button
                                                    >
                                                </b-input-group-append>
                                            </b-input-group>
                                        </b-form-group>
                                    </b-col>
                                    <div class="col-md-12">
                                        <b-overlay
                                            :show="showOverlay"
                                            rounded="sm"
                                        >
                                            <b-table
                                                :fields="fields"
                                                :items="listRegistros"
                                                show-empty
                                                stacked="md"
                                                :head-variant="'dark'"
                                                no-border-collapse
                                                bordered
                                                hover
                                                responsive
                                                :current-page="currentPage"
                                                :per-page="perPage"
                                                @filtered="onFiltered"
                                                empty-text="Sin resultados"
                                                empty-filtered-text="Sin resultados"
                                                :filter="filter"
                                            >
                                                <template #cell(mas)="row">
                                                    <b-button
                                                        variant="danger"
                                                        size="sm"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        {{
                                                            row.detailsShowing
                                                                ? "Ocultar"
                                                                : "Mostrar"
                                                        }}
                                                        Detalles
                                                    </b-button>
                                                </template>

                                                <template #row-details="row">
                                                    <b-card>
                                                        <b-row class="mb-2">
                                                            <b-col
                                                                sm="3"
                                                                class="text-sm-right"
                                                                ><b
                                                                    >Dirección:</b
                                                                ></b-col
                                                            >
                                                            <b-col>{{
                                                                row.item.dir
                                                            }}</b-col>
                                                        </b-row>
                                                        <b-row class="mb-2">
                                                            <b-col
                                                                sm="3"
                                                                class="text-sm-right"
                                                                ><b
                                                                    >Teléfono/Celular:</b
                                                                ></b-col
                                                            >
                                                            <b-col>{{
                                                                row.item.fono
                                                            }}</b-col>
                                                        </b-row>
                                                        <b-button
                                                            size="sm"
                                                            variant="danger"
                                                            @click="
                                                                row.toggleDetails
                                                            "
                                                            >Ocultar</b-button
                                                        >
                                                    </b-card>
                                                </template>

                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
                                                        <b-button
                                                            v-if="
                                                                permisos.includes(
                                                                    'plan_calidads.edit'
                                                                )
                                                            "
                                                            size="sm"
                                                            pill
                                                            variant="outline-warning"
                                                            class="btn-flat btn-block"
                                                            title="Editar registro"
                                                            @click="
                                                                editarRegistro(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-edit"
                                                            ></i>
                                                        </b-button>
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-info"
                                                            class="btn-flat btn-block"
                                                            title="Ver archivos"
                                                            @click="
                                                                verArchivos(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-paperclip"
                                                            ></i>
                                                        </b-button>
                                                        <b-button
                                                            v-if="
                                                                permisos.includes(
                                                                    'plan_calidads.destroy'
                                                                )
                                                            "
                                                            size="sm"
                                                            pill
                                                            variant="outline-danger"
                                                            class="btn-flat btn-block"
                                                            title="Eliminar registro"
                                                            @click="
                                                                eliminaPlanCalidad(
                                                                    row.item.id,
                                                                    row.item
                                                                        .actividad +
                                                                        '<br/><h4>¿Está seguro(a) de eliminar este registro?</h4>'
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
                                                            ></i>
                                                        </b-button>
                                                    </div>
                                                </template>
                                            </b-table>
                                        </b-overlay>
                                        <div class="row">
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="ml-auto my-1"
                                            >
                                                <b-form-select
                                                    align="right"
                                                    id="per-page-select"
                                                    v-model="perPage"
                                                    :options="pageOptions"
                                                    size="sm"
                                                ></b-form-select>
                                            </b-col>
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="my-1 mr-auto"
                                                v-if="perPage"
                                            >
                                                <b-pagination
                                                    v-model="currentPage"
                                                    :total-rows="totalRows"
                                                    :per-page="perPage"
                                                    align="left"
                                                ></b-pagination>
                                            </b-col>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <Nuevo
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :plan_calidad="oPlanCalidad"
            @close="muestra_modal = false"
            @envioModal="getPlanCalidads"
        ></Nuevo>
        <Archivos
            :muestra_modal="muestra_modal_archivos"
            :accion="modal_accion_archivos"
            :plan_calidad="oPlanCalidad"
            @close="muestra_modal_archivos = false"
            @envioModal="getPlanCalidads"
        ></Archivos>
    </div>
</template>

<script>
import Nuevo from "./Nuevo.vue";
import Archivos from "./Archivos.vue";
export default {
    components: {
        Nuevo,
        Archivos,
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
            showOverlay: false,
            fields: [
                {
                    key: "user.full_name",
                    label: "Responsable",
                    sortable: true,
                },
                { key: "actividad", label: "Actividad", sortable: true },
                { key: "norma", label: "Norma ISO", sortable: true },
                { key: "objetivo", label: "Objetivo", sortable: true },
                { key: "plan_archivos.length", label: "Total Archivos" },
                { key: "registros", label: "Registros" },
                {
                    key: "fecha_registro_t",
                    label: "Fecha de registro",
                    sortable: true,
                },
                { key: "accion", label: "Acción" },
            ],
            loading: true,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            muestra_modal_archivos: false,
            modal_accion_archivos: "nuevo",
            modal_accion: "nuevo",
            oPlanCalidad: {
                id: 0,
                user_id: "",
                actividad: "",
                norma: "",
                plan_contingencia_id: "",
                rol_funcion_id: "",
                amenaza_seguridad_id: "",
                actividad_contingencia_id: "",
                objetivo: "",
                registros: "",
                plan_archivos: [],
            },
            currentPage: 1,
            perPage: 5,
            pageOptions: [
                { value: 5, text: "Mostrar 5 Registros" },
                { value: 10, text: "Mostrar 10 Registros" },
                { value: 25, text: "Mostrar 25 Registros" },
                { value: 50, text: "Mostrar 50 Registros" },
                { value: 100, text: "Mostrar 100 Registros" },
                { value: this.totalRows, text: "Mostrar Todo" },
            ],
            totalRows: 10,
            filter: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getPlanCalidads();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.oPlanCalidad.id = item.id;
            this.oPlanCalidad.user_id = item.user_id;
            this.oPlanCalidad.actividad = item.actividad;
            this.oPlanCalidad.norma = item.norma;
            this.oPlanCalidad.plan_contingencia_id = item.plan_contingencia_id;
            this.oPlanCalidad.rol_funcion_id = item.rol_funcion_id;
            this.oPlanCalidad.amenaza_seguridad_id = item.amenaza_seguridad_id;
            this.oPlanCalidad.actividad_contingencia_id =
                item.actividad_contingencia_id;
            this.oPlanCalidad.objetivo = item.objetivo;
            this.oPlanCalidad.registros = item.registros;
            this.modal_accion = "edit";
            this.muestra_modal = true;
        },

        // Listar PlanCalidads
        getPlanCalidads() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = main_url + "/admin/plan_calidads";
            if (this.pagina != 0) {
                url += "?page=" + this.pagina;
            }
            axios
                .get(url, {
                    params: { per_page: this.per_page },
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listRegistros = res.data.plan_calidads;
                    this.totalRows = res.data.total;
                });
        },
        verArchivos(item) {
            this.oPlanCalidad.id = item.id;
            this.oPlanCalidad.user_id = item.user_id;
            this.oPlanCalidad.actividad = item.actividad;
            this.oPlanCalidad.norma = item.norma;
            this.oPlanCalidad.plan_contingencia_id = item.plan_contingencia_id;
            this.oPlanCalidad.rol_funcion_id = item.rol_funcion_id;
            this.oPlanCalidad.amenaza_seguridad_id = item.amenaza_seguridad_id;
            this.oPlanCalidad.actividad_contingencia_id =
                item.actividad_contingencia_id;
            this.oPlanCalidad.objetivo = item.objetivo;
            this.oPlanCalidad.registros = item.registros;
            this.oPlanCalidad.plan_archivos = item.plan_archivos;
            this.muestra_modal_archivos = true;
        },
        eliminaPlanCalidad(id, descripcion) {
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
                        .post(main_url + "/admin/plan_calidads/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getPlanCalidads();
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
        abreModal(tipo_accion = "nuevo", plan_calidad = null) {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
            if (plan_calidad) {
                this.oPlanCalidad = plan_calidad;
            }
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        limpiaPlanCalidad() {
            this.oPlanCalidad.user_id = "";
            this.oPlanCalidad.actividad = "";
            this.oPlanCalidad.norma = "";
            this.oPlanCalidad.plan_contingencia_id = "";
            this.oPlanCalidad.rol_funcion_id = "";
            this.oPlanCalidad.amenaza_seguridad_id = "";
            this.oPlanCalidad.actividad_contingencia_id = "";
            this.oPlanCalidad.objetivo = "";
            this.oPlanCalidad.registros = "";
            this.oPlanCalidad.plan_archivos = [];
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
    },
};
</script>

<style></style>
