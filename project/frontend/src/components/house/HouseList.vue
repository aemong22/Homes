<template>
  <div>
    <b-card
      class="card recent-sales overflow-auto"
      style="width: 100%; height: 850px; margin-left: 20px">
      <h5 class="card-title">최근 매매 <span>| 업데이트 2022-09-07 </span></h5>
      <div class="d-flex justify-content-between align-items-center m-3">
        <div>{{ sido }} {{ gugun }} {{ dong }}</div>

        <div style="pb-3" v-if="checkUserInfo">
          <b-button
            size="sm"
            class="m-1"
            variant="outline-danger"
            @click="confirm()">
            <transition name="bounce">
              <b-icon
                v-if="!checkconcern"
                variant="danger"
                icon="heart"
                scale="1.2"></b-icon>
            </transition>
            <transition name="bounce">
              <b-icon
                v-if="checkconcern"
                variant="danger"
                icon="heart-fill"
                scale="1.2"></b-icon>
            </transition>
            관심지역 찜
          </b-button>
        </div>
      </div>
      <b-container
        v-if="houses && houses.length != 0"
        class="bv-example-row mt-3">
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
    </b-card>
  </div>
</template>

<script>
import HouseListItem from "@/components/house/HouseListItem.vue";
import { mapGetters, mapMutations, mapState, mapActions } from "vuex";
const houseStore = "houseStore";
const memberStore = "memberStore";

export default {
  name: "HouseList",
  components: {
    HouseListItem,
  },
  data() {
    return { perPage: 11, currentPage: 1 };
  },
  created() {
    this.CLEAR_CHECK_CONCERN();
  },
  computed: {
    ...mapGetters(houseStore, [
      "searchType",
      "houses",
      "checkconcern",
      "sido",
      "gugun",
      "dong",
      "dongCode",
    ]),
    ...mapState(memberStore, ["isLogin"]),
    ...mapGetters(memberStore, ["checkUserInfo"]),

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
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    ...mapActions(houseStore, [
      "getCheckConcern",
      "registerConcern",
      "deleteConcern",
    ]),
    ...mapMutations(houseStore, ["CLEAR_CHECK_CONCERN"]),
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
              juso: this.sido + " " + this.gugun + " " + this.dong,
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
  },
};
</script>

<style></style>
