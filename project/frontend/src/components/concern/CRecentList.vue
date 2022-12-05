<template>
  <b-container class="bv-example-row mt-3">
    <div>
      <b-jumbotron class="p-4 bg-white border text-center">
        <h5>최근 관심지역 목록</h5>
        <b-row class="justify-content-md-center mt-4">
          <b-col v-if="concerns && concerns.length != 0" cols="6">
            <b-list-group>
              <c-list-item
                v-for="(concern, index) in concerns"
                :key="index"
                :concern="concern"
                type="recent" />
            </b-list-group>
          </b-col>
          <b-col v-else class="text-center">최근 관심지역이 없습니다.</b-col>
        </b-row>
      </b-jumbotron>
    </div>
  </b-container>
</template>

<script>
import { mapGetters, mapActions, mapMutations } from "vuex";
const houseStore = "houseStore";
export default {
  // data() {
  //   return {
  //     concerns: [],
  //   };
  // },
  created() {
    this.CLEAR_CONCERN_LIST();
    this.getRecentDong();
  },
  methods: {
    ...mapActions(houseStore, ["getRecentConcernList"]),
    ...mapMutations(houseStore, ["CLEAR_CONCERN_LIST"]),
    getRecentDong() {
      let payload = {
        concerns: JSON.parse(sessionStorage.getItem("recent-dong")),
      };
      this.getRecentConcernList(payload);
    },
  },
  computed: {
    ...mapGetters(houseStore, ["concerns"]),
  },
  components: {
    "c-list-item": () => import("@/components/concern/include/CListItem.vue"),
  },
};
</script>
