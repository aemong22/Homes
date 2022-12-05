<template>
  <b-container v-if="house && house.length != 0" class="bv-example-row">
    <template v-if="searchType == 'APT'">
      <!-- <b-row class="mb-2 mt-1">
        <b-col><house-roadview></house-roadview></b-col>
      </b-row> -->
      <!-- <b-row class="mb-2 mt-1">
        <b-col><line-chart></line-chart> </b-col>
      </b-row> -->
      <b-list-group flush>
        <b-list-group-item><house-roadview></house-roadview></b-list-group-item>
        <b-list-group-item><line-chart></line-chart></b-list-group-item>
        <b-list-group-item>일련번호 : {{ house.no }}</b-list-group-item>
        <b-list-group-item
          >아파트 이름 : {{ house.apartmentName }}</b-list-group-item
        >
        <b-list-group-item>법정동 : {{ house.dong }}</b-list-group-item>
        <b-list-group-item>층수 : {{ house.floor }}층</b-list-group-item>
        <b-list-group-item
          >거래금액 :
          {{
            (parseInt(house.dealAmount.replace(",", "")) * 10000) | price
          }}원</b-list-group-item
        >
      </b-list-group>
    </template>
    <template v-else>
      <b-row class="mb-2 mt-1">
        <b-col><house-roadview></house-roadview></b-col>
      </b-row>
      <b-list-group flush>
        <b-list-group-item
          >연립다세대 이름 : {{ house.연립다세대 }}</b-list-group-item
        >
        <b-list-group-item
          >주소 :
          {{
            sido + " " + gugun + house.법정동 + " " + house.지번
          }}</b-list-group-item
        >
        <b-list-group-item>건축년도 : {{ house.건축년도 }}</b-list-group-item>
        <b-list-group-item
          >전용면적 : {{ house.전용면적 }} m<sup>2</sup></b-list-group-item
        >
        <b-list-group-item>층수 : {{ house.층 }}층</b-list-group-item>
        <b-list-group-item
          >거래금액 :
          {{
            (parseInt(house.거래금액.replace(",", "")) * 10000) | price
          }}원</b-list-group-item
        >
      </b-list-group>
    </template>
  </b-container>
</template>

<script>
import { mapGetters } from "vuex";
const houseStore = "houseStore";

export default {
  name: "HouseDetail",
  components: {
    "house-roadview": () => import("@/components/house/HouseRoadview.vue"),
    "line-chart": () => import("@/components/house/LineChart2.vue"),
  },
  computed: {
    ...mapGetters(houseStore, [
      "house",
      "searchType",
      "sido",
      "gugun",
      "aptDealHistroy",
    ]),
  },
  filters: {
    price(value) {
      if (!value) return value;
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
};
</script>

<style scoped></style>
