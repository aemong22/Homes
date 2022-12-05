<template>
  <div>
    <!-- <b-card class="card recent-sales overflow-auto"> -->
    <h5 class="card-title">찜한 관심지역</h5>
    <b-container>
      <b-row class="justify-content-md-center mt-4">
        <b-col v-if="concerns && concerns.length != 0">
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
    </b-container>
    <!-- </b-card> -->
  </div>
</template>

<script>
import { mapState, mapActions, mapGetters, mapMutations } from "vuex";
const houseStore = "houseStore";
const memberStore = "memberStore";

export default {
  // Dynamic module loading을 통해 component를 불러옴
  components: {
    "c-list-item": () =>
      import("@/components/house/concern/include/CListItem.vue"),
  },
  methods: {
    ...mapMutations(houseStore, ["CLEAR_CONCERN_LIST"]),
    ...mapActions(houseStore, ["getConcernList"]),
    createConcernList() {
      if (this.isLogin) {
        const payload = {
          userId: this.checkUserInfo.userId,
          callback: () => {},
        };
        this.getConcernList(payload);
      }
    },
  },
  created() {
    // action 호출
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

<style></style>
