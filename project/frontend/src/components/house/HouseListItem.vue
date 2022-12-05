<template>
  <b-tr
    v-b-modal="index + ''"
    class="text-center m-2"
    @click="selectHouse"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }">
    <template v-if="searchType == 'APT'">
      <b-td>{{ house.apartmentName }}</b-td>
      <b-td>{{ house.floor }}</b-td>
    </template>
    <template v-else>
      <b-td>{{ index + 1 }}</b-td>
      <b-td>{{ house.연립다세대 }}</b-td>
    </template>
    <b-modal :id="index + ''" scrollable hide-footer size="lg" centered
      ><template v-if="searchType == 'APT'" #modal-title>{{
        house.apartmentName
      }}</template>
      <template v-else #modal-title>{{ house.연립다세대 }}</template>
      <house-detail></house-detail>
    </b-modal>
  </b-tr>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
const houseStore = "houseStore";

export default {
  name: "HouseListItem",
  components: {
    "house-detail": () => import("@/components/house/HouseDetail.vue"),
  },
  data() {
    return {
      isColor: false,
    };
  },
  computed: {
    ...mapGetters(houseStore, ["searchType", "aptDealHistroy"]),
  },

  props: {
    house: Object,
    index: Number,
  },
  methods: {
    ...mapActions(houseStore, ["detailHouse", "getAptDealHistroy"]),
    async selectHouse() {
      const payload = {
        aptCode: this.house.aptCode,
        callback: () => {
          this.aptDealHistroy;
        },
      };
      await this.getAptDealHistroy(payload);
      this.detailHouse(this.house);
    },
    colorChange(flag) {
      this.isColor = flag;
    },
  },
};
</script>

<style>
.mouse-over-bgcolor {
  background-color: lightblue;
}

.modal-content {
  border-radius: 25px !important;
  border: none !important;
  max-height: 80vh !important;
}
</style>
