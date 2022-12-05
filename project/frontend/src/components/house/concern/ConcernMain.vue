<template>
  <div>
    <div>
      <b-row id="main1" style="max-width: 98vw">
        <b-col>
          <concern-search-bar></concern-search-bar>
        </b-col>
      </b-row>
      <b-row style="max-width: 99.8vw">
        <b-col xl="4" lg="12" align="left">
          <!-- <b-tabs content-class="mt-3">
            <b-tab title="찜한 관심지역 목록" active><concern-list /></b-tab>
            <b-tab title="매매 내역"><house-list></house-list></b-tab>
          </b-tabs> -->
          <b-card no-body style="width: 100%; height: 850px; margin-left: 20px">
            <b-tabs card>
              <b-tab title="찜한 관심지역 목록" active>
                <b-card-text><concern-list /></b-card-text>
              </b-tab>
              <b-tab title="매매 내역">
                <b-card-text><house-list2></house-list2></b-card-text>
              </b-tab>
            </b-tabs>
          </b-card>
        </b-col>
        <b-col xl="8" md="12">
          <house-map></house-map>
        </b-col>
      </b-row>
    </div>
  </div>
</template>

<script>
import ConcernSearchBar from "@/components/house/concern/ConcernSearhBar.vue";
import ConcernList from "@/components/house/concern/ConcernList.vue";
import HouseMap from "@/components/house/HouseMap.vue";
import HouseList2 from "@/components/house/HouseList2.vue";
export default {
  name: "ConcernMain",
  components: {
    ConcernSearchBar,
    ConcernList,
    HouseMap,
    HouseList2,
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
