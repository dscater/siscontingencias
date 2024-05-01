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
                    <div class="row">
                        <div class="col-12">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th class="text-left" width="20px">
                                            N°
                                        </th>
                                        <th class="text-left">Archivo</th>
                                        <th class="text-center">
                                            Previsualizacion
                                        </th>
                                        <th class="text-center">Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(item, index) in archivos">
                                        <td>{{ index + 1 }}</td>
                                        <td>{{ item.archivo }}</td>
                                        <td class="text-center">
                                            <img
                                                :src="item.url_file"
                                                alt="Previsualizacion"
                                                width="50px"
                                            />
                                        </td>
                                        <td class="text-center">
                                            <button
                                                class="btn btn-primary btn-small"
                                                @click="descargar(item)"
                                            >
                                                <i class="fa fa-download"></i>
                                            </button>
                                            <button
                                                class="btn btn-danger btn-small"
                                                @click="eliminarArchivo(item)"
                                            >
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer justify-content-end">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
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
                this.bModal = true;
                this.archivos = this.plan_calidad.plan_archivos;
            } else {
                this.bModal = false;
            }
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "ARCHIVOS";
            } else {
                return "MODIFICAR REGISTRO";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            archivos: this.plan_calidad.plan_archivos,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
    },
    methods: {
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        descargar(item) {
            window.open(item.url_archivo, "_blank");
        },
        eliminarArchivo(item) {
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${item.archivo}</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#c82333",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post(main_url + "/admin/plan_archivos/" + item.id, {
                            _method: "DELETE",
                        })
                        .then((response) => {
                            Swal.fire({
                                icon: "success",
                                title: response.data.message,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.archivos =
                                response.data.plan_calidad.plan_archivos;
                            this.$emit("envioModal");
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
    },
};
</script>

<style></style>
