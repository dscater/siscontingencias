<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        antese="dialog"
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
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.titulo,
                                    }"
                                    >Título*</label
                                >
                                <el-input
                                    type="textarea"
                                    placeholder="Título"
                                    :class="{ 'is-invalid': errors.titulo }"
                                    v-model="actividad_contingencia.titulo"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.titulo"
                                    v-text="errors.titulo[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.antes,
                                    }"
                                    >Actividades Antes*</label
                                >
                                <el-input
                                    type="textarea"
                                    placeholder="Actividades Antes"
                                    :class="{
                                        'is-invalid': errors.antes,
                                    }"
                                    v-model="actividad_contingencia.antes"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.antes"
                                    v-text="errors.antes[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.durante,
                                    }"
                                    >Actividades Durante*</label
                                >
                                <el-input
                                    type="textarea"
                                    placeholder="Actividades Durante"
                                    :class="{
                                        'is-invalid': errors.durante,
                                    }"
                                    v-model="actividad_contingencia.durante"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.durante"
                                    v-text="errors.durante[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-12">
                                <label
                                    :class="{
                                        'text-danger': errors.despues,
                                    }"
                                    >Actividades Después*</label
                                >
                                <el-input
                                    type="textarea"
                                    placeholder="Actividades Después"
                                    :class="{
                                        'is-invalid': errors.despues,
                                    }"
                                    v-model="actividad_contingencia.despues"
                                    autosize
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.despues"
                                    v-text="errors.despues[0]"
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
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        actividad_contingencia: {
            type: Object,
            default: {
                titulo: "",
                antes: "",
                durante: "",
                despues: "",
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
                return "AGREGAR ACTIVIDAD DE CONTINGENCIA";
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
                let url = main_url + "/admin/actividades_contingencias";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                formdata.append(
                    "titulo",
                    this.actividad_contingencia.titulo
                        ? this.actividad_contingencia.titulo
                        : ""
                );
                formdata.append(
                    "antes",
                    this.actividad_contingencia.antes
                        ? this.actividad_contingencia.antes
                        : ""
                );
                formdata.append(
                    "durante",
                    this.actividad_contingencia.durante
                        ? this.actividad_contingencia.durante
                        : ""
                );
                formdata.append(
                    "despues",
                    this.actividad_contingencia.despues
                        ? this.actividad_contingencia.despues
                        : ""
                );

                if (this.accion == "edit") {
                    url =
                        main_url +
                        "/admin/actividades_contingencias/" +
                        this.actividad_contingencia.id;
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
                        this.limpiaActividadContingencia();
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
        cargaImagen(e) {
            this.actividad_contingencia.foto = e.target.files[0];
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaActividadContingencia() {
            this.errors = [];
            this.actividad_contingencia.titulo = "";
            this.actividad_contingencia.antes = "";
            this.actividad_contingencia.durante = "";
            this.actividad_contingencia.despues = "";
        },
    },
};
</script>

<style></style>
