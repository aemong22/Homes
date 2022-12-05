<template>
  <b-container class="bv-example-row mt-3">
    <div>
      <b-jumbotron class="p-4 bg-white border text-center">
        <h5>찜한 관심지역 목록</h5>

        <b-row class="justify-content-md-center mt-4">
          <b-col v-if="concerns && concerns.length != 0" cols="6">
            <b-list-group>
              <c-list-item
                v-for="(concern, index) in concerns"
                :key="index"
                :concern="concern"
                type="concern" />
            </b-list-group>
          </b-col>
          <b-col v-else class="text-center">등록된 관심지역이 없습니다.</b-col>
        </b-row>
        <b-row class="justify-content-md-center mt-4">
          <b-col cols="8"><bar-chart-concern></bar-chart-concern></b-col
        ></b-row>

        <b-row align-h="center" class="m-2">
          <b-col
            cols="2"
            type="button"
            class="moreButton border rounded py-1 px-3"
            @click="moveConcern"
            >더 알아보기</b-col
          >
        </b-row>
      </b-jumbotron>
    </div>
  </b-container>
</template>

<script>
import { mapState, mapActions, mapGetters, mapMutations } from "vuex";
const houseStore = "houseStore";
const memberStore = "memberStore";

export default {
  // Dynamic module loading을 통해 component를 불러옴
  components: {
    "c-list-item": () => import("@/components/concern/include/CListItem.vue"),
    "bar-chart-concern": () =>
      import("@/components/concern/BarChartConcern.vue"),
  },
  methods: {
    ...mapMutations(houseStore, ["CLEAR_CONCERN_LIST"]),
    ...mapActions(houseStore, [
      "getConcernList",
      "getAptDealyear",
      "getAptDealyearConcern",
    ]),
    async createConcernList() {
      if (this.isLogin) {
        const payload = {
          userId: this.checkUserInfo.userId,
          concernlist: this.concerns,
          callback: () => {
            let concernlist2 = [];
            this.concerns.forEach((concern) => {
              concernlist2.push(concern.dongCode);
            });

            const payload1 = { concerns: concernlist2 };
            this.getAptDealyearConcern(payload1);
          },
        };
        await this.getConcernList(payload);
      }
    },
    moveConcern() {
      this.$router.push({ name: "ConcernMain" });
    },
  },
  created() {
    // action 호출
    this.getAptDealyear();
    this.CLEAR_CONCERN_LIST();
    this.createConcernList();
  },
  computed: {
    ...mapState(memberStore, ["isLogin"]),
    ...mapGetters(houseStore, ["concerns"]),
    ...mapGetters(memberStore, ["checkUserInfo"]),
  },
};
</script>

<style scoped>
@import "@/assets/css/home.css";
</style>
