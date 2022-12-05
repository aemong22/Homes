<template>
  <div>
    <b-list-group-item
      class="d-flex justify-content-between align-items-center"
      @click="selectRegion">
      <span>
        <b-icon icon="geo-alt"></b-icon>
        {{ concern.juso }}</span
      >

      <b-button variant="danger" @click="deleteconcern"
        ><b-icon icon="trash"></b-icon
      ></b-button>
    </b-list-group-item>
  </div>
</template>

<script>
import { mapState, mapActions, mapGetters } from "vuex";
const houseStore = "houseStore";
const memberStore = "memberStore";
export default {
  name: "CListItem",
  props: {
    concern: Object,
    type: { type: String },
  },
  methods: {
    ...mapActions(houseStore, [
      "getConcernList",
      "deleteConcern",
      "getRecentConcernList",
      "searchAddress",
      "setMapLatLng",
      "removeHouseList",
    ]),
    selectRegion() {
      this.remove;
      const payload = {
        query: this.concern.juso,
      };
      this.removeHouseList();
      this.searchAddress(payload);
    },
    deleteconcern() {
      if (this.type == "concern") {
        const payload = {
          userId: this.checkUserInfo.userId,
          dongCode: this.concern.dongCode,
          callback: () => {
            const payload1 = { userId: this.checkUserInfo.userId };
            // 관심목록 갱신
            this.getConcernList(payload1);

            this.$toast.info("관심목록이 삭제되었습니다.", {
              timeout: 3000,
              closeOnClick: true,
              pauseOnFocusLoss: true,
              pauseOnHover: true,
              draggable: true,
              draggablePercent: 0.6,
              showCloseButtonOnHover: false,
              closeButton: "button",
              icon: true,
              rtl: false,
            });
          },
        };

        this.deleteConcern(payload);
      } else {
        let thiz = this;
        let recentDong = sessionStorage.getItem("recent-dong");

        let newDong = JSON.parse(recentDong).filter(function (e) {
          return e.dongCode != thiz.concern.dongCode;
        });

        if (newDong.length > 10) newDong.shift();
        sessionStorage.setItem("recent-dong", JSON.stringify(newDong));

        const payload = { concerns: newDong };
        this.getRecentConcernList(payload);
        this.$toast.info("관심목록이 삭제되었습니다.", {
          timeout: 3000,
          closeOnClick: true,
          pauseOnFocusLoss: true,
          pauseOnHover: true,
          draggable: true,
          draggablePercent: 0.6,
          showCloseButtonOnHover: false,
          closeButton: "button",
          icon: true,
          rtl: false,
        });
      }
    },
  },
  computed: {
    ...mapState(memberStore, ["isLogin"]),
    ...mapGetters(memberStore, ["checkUserInfo"]),
    ...mapGetters(houseStore, ["latlng"]),
  },
};
</script>

<style></style>
