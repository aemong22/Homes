<template>
  <div v-if="concerns && concerns.length != 0">
    <b-card class="shadow" title="관심지역 아파트 매매 년도별 평균 거래 금액">
      <Bar
        :chart-options="chartOptions"
        :chart-data="chartData"
        :chart-id="chartId"
        :dataset-id-key="datasetIdKey"
        :plugins="plugins"
        :css-classes="cssClasses"
        :styles="styles"
        :width="width"
        :height="height"
    /></b-card>
    <div style="display: none">{{ aptDealyearConcern }}</div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
const houseStore = "houseStore";
import { Bar } from "vue-chartjs/legacy";

import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
);

export default {
  name: "BarChart",
  components: {
    Bar,
  },
  props: {
    chartId: {
      type: String,
      default: "bar-chart",
    },
    datasetIdKey: {
      type: String,
      default: "label",
    },
    width: {
      type: Number,
      default: 400,
    },
    height: {
      type: Number,
      default: 400,
    },
    cssClasses: {
      default: "",
      type: String,
    },
    styles: {
      type: Object,
      default: () => {},
    },
    plugins: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      chartData: {
        labels: [
          "2015",
          "2016",
          "2017",
          "2018",
          "2019",
          "2020",
          "2021",
          "2022",
        ],
        datasets: [],
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
      },
      colorlist: [
        "#FFF9CA",
        "#FFDEB4",
        "#FFB4B4",
        "#B2A4FF",
        "#e57373",
        "#f06292",
        "#ba68c8",
        "#9575cd",
        "#7986cb",
        "#64b5f6",
        "#4fc3f7",
        "#4dd0e1",
        "#4db6ac",
        "#81c784",
        "#aed581",
        "#dce775",
      ],
    };
  },
  created() {
    this.updateAptDealyearConcern(this.aptDealyearConcern);
  },
  mounted() {
    this.updateAptDealyearConcern(this.aptDealyearConcern);
  },
  updated() {
    this.updateAptDealyearConcern(this.aptDealyearConcern);
  },
  computed: {
    // barchart
    ...mapGetters(houseStore, ["aptDealyearConcern", "concerns"]),
  },
  methods: {
    ...mapActions(houseStore, ["getAptDealyearConcern", "getConcernList"]),

    // barchart
    async updateAptDealyearConcern(aptDealyearConcern) {
      if (!Array.isArray(aptDealyearConcern)) return;

      let thiz = this;

      let datasetbar = [];
      let color = 0;
      this.concerns.forEach((concern) => {
        color = color % 16;
        let innerdataset = {
          label: concern.juso,
          backgroundColor: thiz.colorlist[color++], //"#6495ed",
          data: [],
        };

        let data3 = [];
        thiz.chartData.labels.forEach((label) => {
          let data2 = aptDealyearConcern.filter(function (e) {
            return e.dongCode == concern.dongCode && e.dealYear == label;
          });

          if (data2.length == 0) {
            data3.push(0);
          } else {
            data3.push(data2[0].avgDeal);
          }
        });

        innerdataset.data = data3;

        datasetbar.push(innerdataset);
      });
      this.chartData.datasets = datasetbar;
    },
  },
};
</script>
<style scoped>
.shadow {
  box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px !important;
}
</style>
