<template>
  <div>
    <b-list-group-item
      class="d-flex justify-content-between align-items-center">
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
      "getAptDealyearConcern",
    ]),
    deleteconcern() {
      if (this.type == "concern") {
        const payload = {
          userId: this.checkUserInfo.userId,
          dongCode: this.concern.dongCode,
          callback: () => {
            const payload2 = {
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
            // 관심목록 갱신
            this.getConcernList(payload2);

            // 삭제 완료 Toast 출력
            // setTimeout(() => {
            //   this.$bvToast.toast("관심목록이 삭제되었습니다.", {
            //     title: "댓글 알림",
            //     variant: "success",
            //     toaster: "b-toaster-bottom-center",
            //     autoHideDelay: 3000,
            //     solid: true,
            //   });
            // }, 500);
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
    ...mapGetters(houseStore, ["concerns"]),
  },
};
</script>

<style></style>
