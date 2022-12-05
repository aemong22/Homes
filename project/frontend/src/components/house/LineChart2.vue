<template>
  <div>
    <LineChartGenerator
      :chart-options="chartOptions"
      :chart-data="chartData"
      :chart-id="chartId"
      :dataset-id-key="datasetIdKey"
      :plugins="plugins"
      :css-classes="cssClasses"
      :styles="styles"
      :width="width"
      :height="height" />
    <div style="display: none">{{ house }}{{ aptDealHistroy }}</div>
    <div></div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
const houseStore = "houseStore";

import { Line as LineChartGenerator } from "vue-chartjs/legacy";

import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  CategoryScale,
  PointElement,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  CategoryScale,
  PointElement,
);

export default {
  name: "LineChart",
  components: {
    LineChartGenerator,
  },
  props: {
    chartId: {
      type: String,
      default: "line-chart",
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
        labels: [],
        datasets: [
          {
            label: "거래 금액 (원)",
            backgroundColor: "#6495ed",
            data: [],
          },
        ],
      },
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
      },
    };
  },
  computed: {
    ...mapGetters(houseStore, ["house", "aptDealHistroy"]),
  },
  created() {
    this.updateaptDealHistroy(this.aptDealHistroy);
  },
  // updated() {
  //   this.updateaptDealHistroy(this.aptDealHistroy);
  // },
  methods: {
    async updateaptDealHistroy(aptDealHistroy) {
      this.chartData.labels = [];
      this.chartData.datasets[0].data = [];
      await aptDealHistroy.forEach((deal) => {
        if (deal.floor == this.house.floor) {
          this.chartData.labels.push(
            deal.dealYear +
              "." +
              deal.dealMonth.padStart(2, "0") +
              "." +
              deal.dealDay,
          );
          var dealAmount = parseInt(deal.dealAmount.replace(",", "")) * 10000;
          this.chartData.datasets[0].data.push(dealAmount);
        }
      });
    },
  },
  watch: {
    changedParams(val) {
      this.deptId = val.deptId;
      this.startDate = val.startDate;
      this.endDate = val.endDate;
    },
  },
};
</script>
