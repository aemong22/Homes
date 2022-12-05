<template>
  <div>
    <h5 class="card-title">최근 매매 <span>| 업데이트 2022-09-07 </span></h5>
    <b-container v-if="houses && houses.length != 0" class="bv-example-row m-3">
      <b-table-simple
        style="min-height: 620px"
        hover
        responsive
        :per-page="perPage"
        :current-page="currentPage">
        <b-thead head-variant="dark">
          <b-tr class="text-center">
            <b-th v-if="searchType == 'MULTIHOUSE'">no</b-th>
            <b-th>아파트</b-th>
            <b-th v-if="searchType == 'APT'">층</b-th>
          </b-tr>
        </b-thead>
        <tbody>
          <house-list-item
            v-for="(house, index) in items"
            :key="index"
            :house="house"
            :index="index"></house-list-item>
        </tbody>
      </b-table-simple>
      <b-pagination
        pills
        align="center"
        v-model="currentPage"
        :total-rows="rows"
        :per-page="perPage"
        aria-controls="my-table"></b-pagination>
    </b-container>
    <b-container v-else class="bv-example-row mt-3">
      <b-row>
        <b-col
          ><b-alert show variant="secondary"
            >주택 목록이 없습니다.</b-alert
          ></b-col
        >
      </b-row>
    </b-container>
  </div>
</template>

<script>
import HouseListItem from "@/components/house/HouseListItem.vue";
import { mapGetters } from "vuex";
const houseStore = "houseStore";

export default {
  name: "HouseList",
  components: {
    HouseListItem,
  },
  data() {
    return { perPage: 11, currentPage: 1 };
  },
  computed: {
    ...mapGetters(houseStore, ["searchType", "houses"]),
    items() {
      return this.houses.slice(
        (this.currentPage - 1) * this.perPage,
        this.currentPage * this.perPage,
      );
    },

    rows() {
      return this.houses.length;
    },
  },
};
</script>

<style></style>
