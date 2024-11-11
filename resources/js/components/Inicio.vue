<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row">
                    <div
                        class="col-12 col-sm-6 col-md-6"
                        v-for="(item, index) in listInfoBox"
                        :key="index"
                    >
                        <div class="small-box" :class="item.color">
                            <div class="informacion">
                                <div class="inner">
                                    <h3>{{ item.cantidad }}</h3>
                                    <p class="text-xl">{{ item.label }}</p>
                                </div>
                                <div class="icon">
                                    <img :src="item.icon" />
                                </div>
                            </div>
                            <router-link
                                :to="{ name: item.url }"
                                class="small-box-footer bg-danger"
                                >Ver más
                                <i class="fas fa-arrow-circle-right"></i
                            ></router-link>
                        </div>
                    </div>
                </div>
                <div class="row" v-if="configuracion">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h2
                                    style="
                                        font-weight: bold;
                                        text-align: center;
                                    "
                                >
                                    {{ configuracion.nombre_sistema }}
                                </h2>
                                <h3 style="text-align: center">
                                    ¡BIENVENID@ {{ user.full_name }}!
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div
                    class="row"
                    v-if="
                        user.tipo == 'SUPERVISOR' ||
                        user.tipo == 'ADMINISTRADOR'
                    "
                >
                    <div class="col-12" id="container"></div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            usuarios: 10,
            configuracion: JSON.parse(localStorage.getItem("configuracion")),
            user: JSON.parse(localStorage.getItem("user")),
            listInfoBox: [],
            htmlMision: "",
            htmlVision: "",
            htmlObjetivos: "",
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getInfoBox();
        if (this.user.tipo == "SUPERVISOR" || this.user.tipo == "ADMINISTRADOR") {
            this.generaReporte();
        }
    },
    methods: {
        getInfoBox() {
            axios.get(main_url + "/admin/usuarios/getInfoBox").then((res) => {
                this.listInfoBox = res.data;
            });
        },
        generaReporte() {
            axios
                .post(
                    main_url + "/admin/reportes/plan_calidad_estados",
                    this.oReporte
                )
                .then((response) => {
                    this.errors = [];
                    Highcharts.chart("container", {
                        chart: {
                            type: "column",
                        },
                        title: {
                            text: "CONTROL DE PLAN DE CALIDAD DE FUNCIONARIOS",
                        },
                        subtitle: {
                            text: "",
                        },
                        xAxis: {
                            type: "category",
                            // crosshair: true,
                            labels: {
                                rotation: -45,
                                style: {
                                    fontSize: "9px",
                                    fontFamily: "Verdana, sans-serif",
                                },
                            },
                        },
                        yAxis: {
                            min: 0,
                            title: {
                                text: "TOTAL",
                            },
                        },
                        legend: {
                            enabled: true,
                        },
                        plotOptions: {
                            series: {
                                borderWidth: 0,
                                dataLabels: {
                                    enabled: true,
                                    format: "{point.y:.2f}",
                                },
                            },
                        },
                        tooltip: {
                            headerFormat:
                                '<span style="font-size:10px"><b>{point.key}</b></span><table>',
                            pointFormat:
                                '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                '<td style="padding:0"><b>{point.y:.0f}</b></td></tr>',
                            footerFormat: "</table>",
                            shared: true,
                            useHTML: true,
                        },

                        series: [
                            {
                                name: "Cantidad",
                                colorByPoint: true,
                                data: response.data.datos,
                                dataLabels: {
                                    rotation: 0,
                                    color: "#000000",
                                    format: "{point.y:.0f}", // one decimal
                                    y: 0, // 10 pixels down from the top
                                    style: {
                                        fontSize: "13px",
                                        fontFamily: "Verdana, sans-serif",
                                    },
                                },
                            },
                        ],
                    });
                    this.enviando = false;
                })
                .catch(async (error) => {
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = error.response.data.errors;
                        }
                    }
                });
        },
    },
};
</script>

<style></style>
