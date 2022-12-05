<template>
  <div>
    <section>
      <b-row>
        <!-- 시도 선택 Card -->
        <b-col xl="2" md="6" class="colpadding">
          <b-card class="card info-card sales-card">
            <h5 class="card-title">시도 <span>| Sido</span></h5>
            <b-form-select
              class="bg-secondary text-light"
              v-model="sidoCode"
              :options="sidos"
              @change="gugunList()"></b-form-select>
          </b-card>
        </b-col>
        <!-- End 시도 선택 -->

        <!-- 구군 선택 Card -->
        <b-col xl="2" md="6" class="colpadding">
          <b-card class="card info-card sales-card">
            <h5 class="card-title">구군 <span>| Gugun</span></h5>
            <b-form-select
              class="bg-secondary text-light"
              v-model="gugunCode"
              :options="guguns"
              @change="dongList"></b-form-select>
          </b-card>
        </b-col>
        <!-- End 구군 선택 -->

        <!-- 동 선택 Card -->
        <b-col no-body xl="2" md="6" class="colpadding">
          <b-card class="card info-card sales-card">
            <h5 class="card-title">동 <span>| Dong</span></h5>
            <b-form-select
              class="bg-secondary text-light"
              v-model="dongCode"
              :options="dongs"
              @change="confirm2"></b-form-select>
          </b-card>
        </b-col>
        <!-- End 동 선택 -->

        <!-- 매매 년도 선택 Card -->
        <b-col xl="2" md="6" class="colpadding">
          <div class="card info-card sales-card">
            <div class="card-body">
              <h5 class="card-title">매매년도 <span>| Year</span></h5>
              <div class="d-flex align-items-center">
                <b-form-select
                  class="bg-dark text-light"
                  v-model="year"
                  :options="years"
                  @change="monthList"></b-form-select>
              </div>
            </div>
          </div>
        </b-col>
        <!-- End 매매 년도 선택 -->

        <!-- 매매 월 Card -->
        <b-col xl="2" md="6" class="colpadding">
          <div class="card info-card sales-card">
            <div class="card-body">
              <h5 class="card-title">매매월 <span>| Month</span></h5>

              <div class="d-flex align-items-center">
                <b-form-select
                  class="bg-dark text-light"
                  v-model="month"
                  :options="months"
                  @change="listenMonth"></b-form-select>
              </div>
            </div>
          </div>
        </b-col>
        <!-- End 매매 월 -->

        <!-- 매매 타입 Card -->
        <b-col xl="2" md="6" class="colpadding">
          <div class="card info-card sales-card">
            <div class="card-body">
              <h5 class="card-title">매매 타입 <span>| type</span></h5>

              <div class="d-flex align-items-center">
                <b-form-select
                  class="bg-dark text-light"
                  v-model="housetype"
                  :options="housetypes"
                  @change="searchOptBtn()"></b-form-select>
              </div>
            </div>
          </div>
        </b-col>
        <!-- End 매매 타입 -->
      </b-row>
      <b-row>
        <b-col>
          <b-card
            ><b-form-group
              class="m-2"
              label="주변 환경 정보 검색"
              v-slot="{ ariaDescribedby }">
              <b-form-checkbox-group
                @change="searchCategory()"
                v-model="selected"
                :options="options"
                :aria-describedby="ariaDescribedby"
                name="buttons-1"
                switches></b-form-checkbox-group> </b-form-group></b-card
        ></b-col>
      </b-row>
    </section>
    <div style="display: none">{{ concerndongcode }}</div>
  </div>
</template>

<script>
import { mapActions, mapMutations, mapGetters, mapState } from "vuex";
const houseStore = "houseStore";
const memberStore = "memberStore";

export default {
  name: "HouseSearchBar",
  data() {
    return {
      sidoCode: null,
      gugunCode: null,
      dongCode: null,
      year: null,
      month: null,
      housetype: null,
      housetypes: [
        { text: "매매 타입", value: null },
        { text: "아파트", value: "APT" },
        { text: "연립다세대", value: "MULTIHOUSE" },
      ],

      selected: [], // Must be an array reference!
      options: [
        { value: "MT1", text: "대형마트" },
        { value: "CS2", text: "편의점" },
        { value: "PS3", text: "어린이집, 유치원" },
        { value: "SC4", text: "학교" },
        { value: "AC5", text: "학원" },
        { value: "PK6", text: "주차장" },
        { value: "OL7", text: "주유소, 충전소" },
        { value: "SW8", text: "지하철역" },
        { value: "BK9", text: "은행" },
        // { value: "CT1", text: "문화시설" },
        // { value: "AG2", text: "중개업소" },
        // { value: "PO3", text: "공공기관" },
        { value: "AT4", text: "관광명소" },
        // { value: "AD5", text: "숙박" },
        { value: "FD6", text: "음식점" },
        { value: "CE7", text: "카페" },
        { value: "HP8", text: "병원" },
        // { value: "PM9", text: "약국" },
      ],

      ckconcern: false,
    };
  },
  computed: {
    ...mapGetters(houseStore, [
      "sidos",
      "guguns",
      "dongs",
      "houses",
      "years",
      "months",
      "checkconcern",
      "concerndongcode",
    ]),
    ...mapState(memberStore, ["isLogin"]),
    ...mapGetters(memberStore, ["checkUserInfo"]),
    sidoText: function () {
      const report = this.sidos.find((sido) => sido.value === this.sidoCode);
      return report.text;
    },
    gugunText: function () {
      const report = this.guguns.find(
        (gugun) => gugun.value === this.gugunCode,
      );
      return report.text;
    },
    dongText: function () {
      const report = this.dongs.find((dong) => dong.value === this.dongCode);
      return report.text;
    },
  },
  created() {
    this.CLEAR_SIDO_LIST();
    this.CLEAR_GUGUN_LIST();
    this.CLEAR_DONG_LIST();
    this.CLEAR_APT_LIST();
    this.getSido();
    this.CLEAR_YEAR_LIST();
    this.CLEAR_MONTH_LIST();
    this.getYear();
    this.CLEAR_SIDO();
    this.CLEAR_GUGUN();
    this.latlng();
    this.CLEAR_CATEGORY_LIST();
    this.CLEAR_CATEGORYSRESULT_LIST();
    this.CLEAR_CHECK_CONCERN();
    this.CLEAR_CONCERN_DONGCODE();
    this.housetype = null;
    this.removeHouseList();
  },
  updated() {
    this.concernselect(this.concerndongcode);
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    ...mapActions(houseStore, [
      "getSido",
      "getGugun",
      "getDong",
      "getHouseList",
      "getYear",
      "getMonth",
      "getMultiHouseList",
      "getSearchCategoryList",
      "getCheckConcern",
      "registerConcern",
      "deleteConcern",
      "removeHouseList",
    ]),
    ...mapMutations(houseStore, [
      "CLEAR_SIDO_LIST",
      "CLEAR_GUGUN_LIST",
      "CLEAR_DONG_LIST",
      "CLEAR_APT_LIST",
      "CLEAR_YEAR_LIST",
      "CLEAR_MONTH_LIST",
      "CLEAR_SIDO",
      "CLEAR_GUGUN",
      "CLEAR_SEARCHTYPE",
      "CLEAR_CATEGORY_LIST",
      "CLEAR_CATEGORYSRESULT_LIST",
      "CLEAR_CHECK_CONCERN",
      "CLEAR_CONCERN_DONGCODE",
    ]),
    ...mapGetters(houseStore, ["latlng", "categorys"]),
    gugunList() {
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_DONG_LIST();
      this.gugunCode = null;
      this.dongCode = null;
      this.CLEAR_SIDO();
      this.CLEAR_GUGUN();
      this.CLEAR_CHECK_CONCERN();
      this.housetype = null;
      if (this.sidoCode) this.getGugun(this.sidoCode);
    },
    dongList() {
      this.CLEAR_DONG_LIST();
      this.dongCode = null;
      this.CLEAR_SIDO();
      this.CLEAR_GUGUN();
      this.CLEAR_CHECK_CONCERN();
      this.housetype = null;
      if (this.gugunCode) this.getDong(this.gugunCode);
    },
    monthList() {
      this.housetype = null;
      this.CLEAR_MONTH_LIST();
      if (this.year) this.getMonth(this.year);
    },
    searchApt() {
      const payload = {
        dongCode: this.dongCode,
        year: this.year,
        month: this.month,
        sido: this.sidoText,
        gugun: this.gugunText,
        dong: this.dongText,
      };
      if (this.dongCode && this.year && this.month) {
        this.selected = [];
        this.CLEAR_CATEGORYSRESULT_LIST();
        this.CLEAR_SEARCHTYPE();
        this.CLEAR_APT_LIST();
        this.getHouseList(payload);

        let payload2 = {
          dongCode: payload.dongCode,
          juso: payload.sido + " " + payload.gugun + " " + payload.dong,
        };

        if (this.isLogin) {
          let recentDong = sessionStorage.getItem("recent-dong");
          if (recentDong == null) {
            sessionStorage.setItem("recent-dong", JSON.stringify([payload2]));
          } else {
            let newDong = JSON.parse(recentDong).filter(function (e) {
              return e.dongCode != payload.dongCode;
            });
            newDong.push(payload2);

            if (newDong.length > 10) newDong.shift();
            sessionStorage.setItem("recent-dong", JSON.stringify(newDong));
          }
        }
      } else {
        this.$toast.warning("매매정보 선택 메뉴 확인", {
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
        this.housetype = null;
      }
    },
    searchHouse() {
      const payload = {
        dongCode: this.dongCode,
        year: this.year,
        month: this.month,
        sido: this.sidoText,
        gugun: this.gugunText,
        dong: this.dongText,
      };
      if (this.dongCode && this.year && this.month) {
        this.selected = [];
        this.CLEAR_CATEGORYSRESULT_LIST();
        this.CLEAR_SEARCHTYPE();
        this.CLEAR_APT_LIST();
        this.getMultiHouseList(payload);

        let payload2 = {
          dongCode: payload.dongCode,
          juso: payload.sido + " " + payload.gugun + " " + payload.dong,
        };
        if (this.isLogin) {
          let recentDong = sessionStorage.getItem("recent-dong");
          if (recentDong == null) {
            sessionStorage.setItem("recent-dong", JSON.stringify([payload2]));
          } else {
            let newDong = JSON.parse(recentDong).filter(function (e) {
              return e.dongCode != payload.dongCode;
            });

            newDong.push(payload2);

            if (newDong.length > 10) newDong.shift();
            sessionStorage.setItem("recent-dong", JSON.stringify(newDong));
          }
        }
      } else {
        this.$toast.warning("매매정보 선택 메뉴 확인", {
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
        this.housetype = null;
      }
    },

    searchCategory() {
      const insertcategory = this.selected.filter(
        (x) => !this.categorys().includes(x),
      );
      const payload = {
        selected: this.selected,
        category: insertcategory,
        latlng: this.latlng(),
      };
      this.getSearchCategoryList(payload);
    },

    confirm() {
      if (this.isLogin) {
        if (this.checkconcern) {
          // 관심지역 삭제
          const payload = {
            userId: this.checkUserInfo.userId,
            dongCode: this.dongCode,
          };
          this.deleteConcern(payload);
        } else {
          if (!this.dongCode) {
            this.$toast.warning("찜하기를 위해 지역(동)을 선택해주세요.", {
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
          } else {
            // 관심지역 등록
            const payload = {
              userId: this.checkUserInfo.userId,
              juso: this.sidoText + " " + this.gugunText + " " + this.dongText,
              dongCode: this.dongCode,
            };
            this.registerConcern(payload);
          }
        }
      } else {
        this.$toast.warning("찜하기를 위해 지역(동)을 선택해주세요.", {
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

    confirm2() {
      // 동값이 변할 때
      this.CLEAR_CATEGORY_LIST();
      this.housetype = null;
      if (this.isLogin && this.checkUserInfo) {
        if (this.dongCode) {
          const payload = {
            userId: this.checkUserInfo.userId,
            dongCode: this.dongCode,
          };
          this.getCheckConcern(payload);
        }
      }
    },

    concernselect(concerndongcode) {
      if (concerndongcode == null) return;

      if (this.sidoCode == concerndongcode.substr(0, 2) + "00000000") return;
      if (this.gugunCode == concerndongcode.substr(0, 5) + "00000") return;
      if (this.dongCode == concerndongcode) return;

      this.sidoCode = concerndongcode.substr(0, 2) + "00000000";
      this.gugunList();
      this.gugunCode = concerndongcode.substr(0, 5) + "00000";
      this.dongList();
      this.dongCode = concerndongcode;
      this.housetype = null;
    },
    searchOptBtn() {
      if (this.housetype == null) {
        return;
      } else if (this.housetype == "APT") {
        this.searchApt();
      } else if (this.housetype == "MULTIHOUSE") {
        this.searchHouse();
      }
    },
    listenMonth() {
      this.housetype = null;
    },
  },
};
</script>

<style>
.bounce-enter-active {
  animation: bounce-in 0.5s;
}

@keyframes bounce-in {
  0% {
    transform: scale(0);
  }
  50% {
    transform: scale(1.25);
  }
  100% {
    transform: scale(1);
  }
}
.colpadding {
  padding-left: 5px;
  padding-right: 5px;
}
</style>
