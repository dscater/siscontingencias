<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-dark">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.user_id,
                                    }"
                                    >Responsable*</label
                                >
                                <el-select
                                    placeholder="Responsable"
                                    class="w-100"
                                    :class="{ 'is-invalid': errors.user_id }"
                                    v-model="plan_calidad.user_id"
                                    filtereable
                                >
                                    <el-option
                                        v-for="item in listFuncionarios"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.full_name"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.user_id"
                                    v-text="errors.user_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.actividad,
                                    }"
                                    >Actividad*</label
                                >

                                <el-input
                                    type="textarea"
                                    placeholder="Actividad"
                                    :class="{ 'is-invalid': errors.actividad }"
                                    v-model="plan_calidad.actividad"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.actividad"
                                    v-text="errors.actividad[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.norma,
                                    }"
                                    >Norma ISO*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.norma,
                                    }"
                                    v-model="plan_calidad.norma"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listTipos"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.norma"
                                    v-text="errors.norma[0]"
                                ></span>
                            </div>

                            <!-- PLAN DE CONTIGENCIAS -->
                            <div
                                class="form-group col-md-6"
                                v-if="
                                    plan_calidad.norma == 'PLAN DE CONTIGENCIAS'
                                "
                            >
                                <label
                                    :class="{
                                        'text-danger':
                                            errors.plan_contingencia_id,
                                    }"
                                    >Selccionar Plan de Contingencia*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid':
                                            errors.plan_contingencia_id,
                                    }"
                                    v-model="plan_calidad.plan_contingencia_id"
                                    clearable
                                >
                                    <el-option
                                        v-for="(
                                            item, index
                                        ) in listPlanContingencias"
                                        :key="index"
                                        :value="item.id"
                                        :label="item.titulo"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.plan_contingencia_id"
                                    v-text="errors.plan_contingencia_id[0]"
                                ></span>
                            </div>
                            <!-- ROLES Y FUNCIONES -->
                            <div
                                class="form-group col-md-6"
                                v-if="plan_calidad.norma == 'ROLES Y FUNCIONES'"
                            >
                                <label
                                    :class="{
                                        'text-danger': errors.rol_funcion_id,
                                    }"
                                    >Selccionar Rol y Función*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.rol_funcion_id,
                                    }"
                                    v-model="plan_calidad.rol_funcion_id"
                                    clearable
                                >
                                    <el-option
                                        v-for="(
                                            item, index
                                        ) in listRolesFunciones"
                                        :key="index"
                                        :value="item.id"
                                        :label="item.titulo"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.rol_funcion_id"
                                    v-text="errors.rol_funcion_id[0]"
                                ></span>
                            </div>
                            <!-- AMENAZAS Y SEGURDAD -->
                            <div
                                class="form-group col-md-6"
                                v-if="
                                    plan_calidad.norma == 'AMENAZAS Y SEGURDAD'
                                "
                            >
                                <label
                                    :class="{
                                        'text-danger':
                                            errors.amenaza_seguridad_id,
                                    }"
                                    >Selccionar Amenaza y Seguridad*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid':
                                            errors.amenaza_seguridad_id,
                                    }"
                                    v-model="plan_calidad.amenaza_seguridad_id"
                                    clearable
                                >
                                    <el-option
                                        v-for="(
                                            item, index
                                        ) in listAmenzasSeguridad"
                                        :key="index"
                                        :value="item.id"
                                        :label="item.titulo"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.amenaza_seguridad_id"
                                    v-text="errors.amenaza_seguridad_id[0]"
                                ></span>
                            </div>

                            <!-- ACTIVIDADES DE CONTINGENCIAS -->
                            <div
                                class="form-group col-md-6"
                                v-if="
                                    plan_calidad.norma ==
                                    'ACTIVIDADES DE CONTINGENCIAS'
                                "
                            >
                                <label
                                    :class="{
                                        'text-danger':
                                            errors.actividad_contingencia_id,
                                    }"
                                    >Selccionar Actividad de
                                    Contingencia*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid':
                                            errors.actividad_contingencia_id,
                                    }"
                                    v-model="
                                        plan_calidad.actividad_contingencia_id
                                    "
                                    clearable
                                >
                                    <el-option
                                        v-for="(
                                            item, index
                                        ) in listActividadContingencias"
                                        :key="index"
                                        :value="item.id"
                                        :label="item.titulo"
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.actividad_contingencia_id"
                                    v-text="errors.actividad_contingencia_id[0]"
                                ></span>
                            </div>

                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.objetivo,
                                    }"
                                    >Objetivo (identificar el problema)*</label
                                >

                                <el-input
                                    type="textarea"
                                    placeholder="Objetivo"
                                    :class="{ 'is-invalid': errors.objetivo }"
                                    v-model="plan_calidad.objetivo"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.objetivo"
                                    v-text="errors.objetivo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.registros,
                                    }"
                                    >Registros*</label
                                >

                                <el-input
                                    type="textarea"
                                    placeholder="Registros"
                                    :class="{ 'is-invalid': errors.registros }"
                                    v-model="plan_calidad.registros"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.registros"
                                    v-text="errors.registros[0]"
                                ></span>
                            </div>
                            <div class="col-12 form-group">
                                <label>Agregar documentos operativos</label>
                                <div class="row">
                                    <div class="col-12">
                                        <MiDropZone
                                            :files="
                                                this.plan_calidad.plan_archivos
                                            "
                                            @UpdateFiles="detectaArchivos"
                                        ></MiDropZone>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="danger"
                        class="bg-danger"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import MiDropZone from "../../MiDropZone";

export default {
    components: {
        MiDropZone,
    },
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        plan_calidad: {
            type: Object,
            default: {
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
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.getFuncionarios();
                this.getPlanContingencias();
                this.getRolesFunciones();
                this.getAmenazasSeguridad();
                this.getActividadesContingencias();
                this.bModal = true;

                EventBus.$emit("vaciaArchivos", []);
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "AGREGAR REGISTRO";
            } else {
                return "MODIFICAR REGISTRO";
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            listFuncionarios: [],
            listTipos: [
                "PLAN DE CONTIGENCIAS",
                "ROLES Y FUNCIONES",
                "AMENAZAS Y SEGURDAD",
                "ACTIVIDADES DE CONTINGENCIAS",
            ],
            listPlanContingencias: [],
            listRolesFunciones: [],
            listAmenzasSeguridad: [],
            listActividadContingencias: [],
            errors: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getFuncionarios();
    },
    methods: {
        getPlanContingencias() {
            axios
                .get(main_url + "/admin/plan_contingencias/lista")
                .then((response) => {
                    this.listPlanContingencias =
                        response.data.plan_contingencias;
                });
        },
        getRolesFunciones() {
            axios
                .get(main_url + "/admin/roles_funciones/lista")
                .then((response) => {
                    this.listRolesFunciones = response.data.roles_funciones;
                });
        },
        getAmenazasSeguridad() {
            axios
                .get(main_url + "/admin/amenazas_seguridad/lista")
                .then((response) => {
                    this.listAmenzasSeguridad =
                        response.data.amenazas_seguridad;
                });
        },
        getActividadesContingencias() {
            axios
                .get(main_url + "/admin/actividades_contingencias/lista")
                .then((response) => {
                    this.listActividadContingencias =
                        response.data.actividades_contingencias;
                });
        },
        getFuncionarios() {
            axios
                .get(main_url + "/admin/usuarios/getUsuarioTipo", {
                    params: {
                        tipo: "FUNCIONARIO",
                    },
                })
                .then((response) => {
                    this.listFuncionarios = response.data;
                });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = main_url + "/admin/plan_calidads";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "user_id",
                    this.plan_calidad.user_id ? this.plan_calidad.user_id : ""
                );
                formdata.append(
                    "actividad",
                    this.plan_calidad.actividad
                        ? this.plan_calidad.actividad
                        : ""
                );
                formdata.append(
                    "norma",
                    this.plan_calidad.norma ? this.plan_calidad.norma : ""
                );
                formdata.append(
                    "plan_contingencia_id",
                    this.plan_calidad.plan_contingencia_id
                        ? this.plan_calidad.plan_contingencia_id
                        : ""
                );
                formdata.append(
                    "rol_funcion_id",
                    this.plan_calidad.rol_funcion_id
                        ? this.plan_calidad.rol_funcion_id
                        : ""
                );
                formdata.append(
                    "amenaza_seguridad_id",
                    this.plan_calidad.amenaza_seguridad_id
                        ? this.plan_calidad.amenaza_seguridad_id
                        : ""
                );
                formdata.append(
                    "actividad_contingencia_id",
                    this.plan_calidad.actividad_contingencia_id
                        ? this.plan_calidad.actividad_contingencia_id
                        : ""
                );
                formdata.append(
                    "objetivo",
                    this.plan_calidad.objetivo ? this.plan_calidad.objetivo : ""
                );
                formdata.append(
                    "registros",
                    this.plan_calidad.registros
                        ? this.plan_calidad.registros
                        : ""
                );

                this.plan_calidad.plan_archivos.forEach((elem) => {
                    formdata.append("plan_archivos[]", elem);
                });

                if (this.accion == "edit") {
                    url =
                        main_url +
                        "/admin/plan_calidads/" +
                        this.plan_calidad.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        Swal.fire({
                            icon: "success",
                            title: res.data.msj,
                            showConfirmButton: false,
                            timer: 1500,
                        });
                        this.limpiaPlanCalidad();
                        this.$emit("envioModal");
                        this.errors = [];
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
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
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        detectaArchivos(files) {
            this.plan_calidad.plan_archivos = [];
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                this.plan_calidad.plan_archivos.push(file.file);
            }
            console.log(this.plan_calidad.plan_archivos);
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaPlanCalidad() {
            this.errors = [];
            this.plan_calidad.nombre = "";
            this.plan_calidad.user_id = "";
            this.plan_calidad.actividad = "";
            this.plan_calidad.norma = "";
            this.plan_calidad.plan_contingencia_id = "";
            this.plan_calidad.rol_funcion_id = "";
            this.plan_calidad.amenaza_seguridad_id = "";
            this.plan_calidad.actividad_contingencia_id = "";
            this.plan_calidad.objetivo = "";
            this.plan_calidad.registros = "";
            this.plan_calidad.plan_archivos = [];
        },
    },
};
</script>

<style></style>
