<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Control Plan de Calidad > Seguimiento</h1>
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
                                <router-link
                                    :to="{ name: 'controls.index' }"
                                    href=""
                                    class="btn btn-default btn-sm"
                                    ><i class="fa fa-arrow-left"></i
                                ></router-link>

                                SEGUIMIENTO - {{ userSeguimiento.full_name }}
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
                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
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
                                                            size="sm"
                                                            pill
                                                            variant="outline-warning"
                                                            title="Editar"
                                                            class="btn-flat btn-block"
                                                            @click="
                                                                editar(row.item)
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-edit"
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
        <Estado
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :plan_calidad="oPlanCalidad"
            @close="muestra_modal = false"
            @envioModal="getControls"
        ></Estado>
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
import Estado from "./Estado.vue";
import Archivos from "../plan_calidads/Archivos.vue";
export default {
    components: {
        Estado,
        Archivos,
    },
    props: ["id"],
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
                { key: "actividad", label: "Actividad", sortable: true },
                { key: "norma", label: "Norma ISO", sortable: true },
                { key: "objetivo", label: "Objetivo", sortable: true },
                { key: "plan_archivos.length", label: "Total Archivos" },
                { key: "registros", label: "Registros" },
                { key: "estado", label: "Estado" },
                { key: "descripcion", label: "Descripción" },
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
            modal_accion: "nuevo",
            muestra_modal_archivos: false,
            modal_accion_archivos: "nuevo",
            oPlanCalidad: {
                id: 0,
                estado: "",
                descripcion: "",
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
            userSeguimiento: {
                full_name: "",
            },
            totalRows: 10,
            filter: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getControls();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editar(item) {
            this.oPlanCalidad.id = item.id;
            this.oPlanCalidad.estado = item.estado;
            this.oPlanCalidad.descripcion = item.descripcion;
            this.modal_accion = "edit";
            this.muestra_modal = true;
        },
        // Listar Controls
        getControls() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = main_url + "/admin/controls/seguimiento/" + this.id;
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
                    this.userSeguimiento = res.data.user;
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
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
    },
};
</script>

<style></style>
