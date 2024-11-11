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
                                        'text-danger': errors.estado,
                                    }"
                                    >Estado*</label
                                >
                                <el-select
                                    class="w-100 d-block"
                                    :class="{
                                        'is-invalid': errors.estado,
                                    }"
                                    v-model="plan_calidad.estado"
                                    clearable
                                >
                                    <el-option
                                        v-for="(item, index) in listEstados"
                                        :key="index"
                                        :value="item"
                                        :label="item"
                                    ></el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.estado"
                                    v-text="errors.estado[0]"
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
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.descripcion,
                                    }"
                                    >Descripción*</label
                                >

                                <el-input
                                    type="textarea"
                                    placeholder="Descripción"
                                    :class="{
                                        'is-invalid': errors.descripcion,
                                    }"
                                    v-model="plan_calidad.descripcion"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.descripcion"
                                    v-text="errors.descripcion[0]"
                                ></span>
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
                estado: "",
                descripcion: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
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
                return "EDITAR ESTADO";
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
            listEstados: ["PENDIENTE", "OBSERVADO", "FINALIZADO"],
            errors: [],
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = main_url + "/admin/plan_calidads/update_estado/";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "estado",
                    this.plan_calidad.estado ? this.plan_calidad.estado : ""
                );
                formdata.append(
                    "descripcion",
                    this.plan_calidad.descripcion
                        ? this.plan_calidad.descripcion
                        : ""
                );
                if (this.accion == "edit") {
                    url =
                        main_url +
                        "/admin/plan_calidads/update_estado/" +
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
