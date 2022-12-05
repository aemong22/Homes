<template>
  <div>
    <b-row id="main1" style="max-width: 98vw">
      <b-col>
        <house-search-bar></house-search-bar>
      </b-col>
    </b-row>
    <b-row style="max-width: 99.8vw">
      <b-col xl="4" lg="12" align="left">
        <house-list style="width: 100%; height: 850px" />
      </b-col>
      <b-col xl="8" md="12">
        <house-map></house-map>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import HouseSearchBar from "@/components/house/HouseSearchBar.vue";
import HouseList from "@/components/house/HouseList.vue";
import HouseMap from "@/components/house/HouseMap.vue";

export default {
  name: "AppHouse",
  components: {
    HouseSearchBar,
    HouseList,
    HouseMap,
  },
};
</script>
<style scoped>
@media (min-width: 1200px) {
  #main1 {
    margin-left: 10px;
  }
}
</style>
