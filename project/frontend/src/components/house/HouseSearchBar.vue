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
              @change="gugunList($event)"></b-form-select>
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
                  :options="months"></b-form-select>
              </div>
            </div>
          </div>
        </b-col>
        <!-- End 매매 월 -->

        <!-- 매매 타입 버튼 Card -->
        <b-col xl="2" md="6" class="colpadding">
          <div class="card info-card sales-card">
            <div class="card-body">
              <h5 class="card-title">매매 타입<span>| Type</span></h5>

              <div class="d-flex align-items-center">
                <div>
                  <b-button
                    size="sm"
                    class="m-1"
                    variant="outline-dark"
                    @click="searchApt">
                    아파트<b-icon icon="search"></b-icon>
                  </b-button>
                  <b-button
                    size="sm"
                    class="m-1"
                    variant="outline-dark"
                    @click="searchHouse">
                    연립다세대 <b-icon icon="search"></b-icon>
                  </b-button>
                </div>
              </div>
            </div>
          </div>
        </b-col>
        <!-- End 매매 타입 -->
      </b-row>
    </section>
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
    this.CLEAR_DONG();
    this.CLEAR_DONGCODE();
    this.latlng();
    this.CLEAR_CATEGORY_LIST();
    this.CLEAR_CATEGORYSRESULT_LIST();
    this.CLEAR_CHECK_CONCERN();
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
      "setSido",
      "setGugun",
      "setDong",
      "setDongCode",
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
      "CLEAR_DONG",
      "CLEAR_SEARCHTYPE",
      "CLEAR_CATEGORY_LIST",
      "CLEAR_CATEGORYSRESULT_LIST",
      "CLEAR_CHECK_CONCERN",
      "CLEAR_DONGCODE",
    ]),
    ...mapGetters(houseStore, ["latlng", "categorys"]),
    gugunList() {
      this.CLEAR_GUGUN_LIST();
      this.CLEAR_DONG_LIST();
      this.gugunCode = null;
      this.dongCode = null;
      this.CLEAR_GUGUN();
      this.CLEAR_DONG();
      this.CLEAR_CHECK_CONCERN();
      if (this.sidoCode) {
        this.getGugun(this.sidoCode);
        this.setSido(this.sidoText);
      }
    },
    dongList() {
      this.CLEAR_DONG_LIST();
      this.dongCode = null;
      this.CLEAR_DONGCODE();
      this.CLEAR_GUGUN();
      this.CLEAR_DONG();
      this.CLEAR_CHECK_CONCERN();
      if (this.gugunCode) {
        this.getDong(this.gugunCode);
        this.setGugun(this.gugunText);
      }
    },
    monthList() {
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

    confirm2() {
      // 동값이 변할 때
      this.setDong(this.dongText);
      this.setDongCode(this.dongCode);
      this.CLEAR_CATEGORY_LIST();
      if (this.isLogin) {
        if (this.dongCode) {
          const payload = {
            userId: this.checkUserInfo.userId,
            dongCode: this.dongCode,
          };
          this.getCheckConcern(payload);
        }
      }
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
