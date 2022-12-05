import {
  sidoList,
  gugunList,
  dongList,
  houseList,
  multihouseList,
  searchCategoryList,
  ckConcern,
  registerConcern,
  deleteConcern,
  getConcernList,
  getAptDealHistroy,
  searchAddress,
  getAptDealyear,
  getAptDealyearConcern,
} from "@/api/house.js";

const houseStore = {
  namespaced: true,
  state: {
    sidos: [{ value: null, text: "시도선택" }],
    guguns: [{ value: null, text: "구군선택" }],
    dongs: [{ value: null, text: "동선택" }],
    years: [{ value: null, text: "매매년도선택" }],
    months: [{ value: null, text: "매매월선택" }],
    houses: [],
    house: null,
    sido: null,
    gugun: null,
    dong: null,
    dongCode: null,
    searchType: null,
    categorys: [],
    latlng: { lat: 33.450701, lng: 126.570667 },
    categorysresult: {
      MT1: null,
      CS2: null,
      PS3: null,
      SC4: null,
      AC5: null,
      PK6: null,
      OL7: null,
      SW8: null,
      BK9: null,
      CT1: null,
      AG2: null,
      PO3: null,
      AT4: null,
      AD5: null,
      FD6: null,
      CE7: null,
      HP8: null,
      PM9: null,
    },
    //////////////// concern start ////////////////////////
    checkconcern: false,
    concerns: [],
    concerndongcode: null,
    concernlatlng: { lat: "", lng: "" },
    //////////////// concern end //////////////////////////
    aptDealHistroy: [],
    aptDealyear: {},
    aptDealyearConcern: {},
  },
  getters: {
    sidos(state) {
      return state.sidos;
    },
    guguns(state) {
      return state.guguns;
    },
    dongs(state) {
      return state.dongs;
    },
    years(state) {
      return state.years;
    },
    months(state) {
      return state.months;
    },
    houses(state) {
      return state.houses;
    },
    house(state) {
      return state.house;
    },
    sido(state) {
      return state.sido;
    },
    gugun(state) {
      return state.gugun;
    },
    dong(state) {
      return state.dong;
    },
    dongCode(state) {
      return state.dongCode;
    },
    concerndongcode(state) {
      return state.concerndongcode;
    },
    searchType(state) {
      return state.searchType;
    },
    categorys(state) {
      return state.categorys;
    },
    latlng(state) {
      return state.latlng;
    },
    concernlatlng(state) {
      return state.concernlatlng;
    },
    categorysresult(state) {
      return state.categorysresult;
    },
    //////////////// concern start ////////////////////////
    checkconcern(state) {
      return state.checkconcern;
    },
    concerns(state) {
      return state.concerns;
    },
    //////////////// concern end //////////////////////////
    aptDealHistroy(state) {
      return state.aptDealHistroy;
    },
    aptDealyear(state) {
      return state.aptDealyear;
    },
    aptDealyearConcern(state) {
      return state.aptDealyearConcern;
    },
  },
  mutations: {
    /////////////////////////////// House start /////////////////////////////////////
    CLEAR_SIDO_LIST(state) {
      state.sidos = [{ value: null, text: "시도선택" }];
    },
    SET_SIDO_LIST(state, sidos) {
      sidos.forEach((sido) => {
        state.sidos.push({ value: sido.dongCode, text: sido.sidoName });
      });
    },
    CLEAR_GUGUN_LIST(state) {
      state.guguns = [{ value: null, text: "구군선택" }];
    },
    SET_GUGUN_LIST(state, guguns) {
      guguns.forEach((gugun) => {
        state.guguns.push({ value: gugun.dongCode, text: gugun.gugunName });
      });
    },
    CLEAR_DONG_LIST(state) {
      state.dongs = [{ value: null, text: "동선택" }];
    },
    SET_DONG_LIST(state, dongs) {
      dongs.forEach((dong) => {
        state.dongs.push({ value: dong.dongCode, text: dong.dongName });
      });
    },
    CLEAR_DONGCODE(state) {
      state.dongCode = null;
    },
    SET_DONGCODE(state, dongCode) {
      state.dongCode = dongCode;
    },
    CLEAR_APT_LIST(state) {
      state.houses = [];
      state.house = null;
    },
    SET_HOUSE_LIST(state, houses) {
      state.houses = houses;
    },
    SET_MULTIHOUSE_LIST(state, houses) {
      state.houses = houses.filter(function (e) {
        return e[`법정동`].trim() == state.dong;
      });
    },
    SET_DETAIL_HOUSE(state, house) {
      state.house = house;
    },
    CLEAR_SIDO(state) {
      state.sido = null;
    },
    SET_SIDO(state, sido) {
      state.sido = sido;
    },
    CLEAR_GUGUN(state) {
      state.gugun = null;
    },
    SET_GUGUN(state, gugun) {
      state.gugun = gugun;
    },
    CLEAR_DONG(state) {
      state.dong = null;
      state.dongcode = null;
    },
    SET_DONG(state, dong) {
      state.dong = dong;
    },
    CLEAR_CONCERN_DONGCODE(state) {
      state.concerndongcode = null;
    },
    SET_CONCERN_DONGCODE(state, concerndongcode) {
      state.concerndongcode = concerndongcode;
    },
    CLEAR_SEARCHTYPE(state) {
      state.searchType = null;
    },
    SET_SEARCHTYPE(state, searchType) {
      state.searchType = searchType;
    },
    /////////////////////////////// Date start ////////////////////////////////////
    CLEAR_YEAR_LIST(state) {
      state.years = [{ value: null, text: "매매년도선택" }];
    },

    SET_YEAR_LIST(state) {
      let date = new Date();
      let year = date.getFullYear();
      for (let i = year; i > year - 20; i--) {
        state.years.push({ value: i, text: i + "년" });
      }
    },
    CLEAR_MONTH_LIST(state) {
      state.months = [{ value: null, text: "매매월선택" }];
    },
    SET_MONTH_LIST(state, year) {
      let date = new Date();
      let month = date.getMonth() + 1;
      let m = year == date.getFullYear() ? month : 13;
      for (let i = 1; i < m; i++) {
        state.months.push({ value: i < 10 ? "0" + i : i, text: i + "월" });
      }
    },
    /////////////////////////////// Date end /////////////////////////////////////
    CLEAR_CATEGORY_LIST(state) {
      state.categorys = [];
    },
    SET_CATEGORY_LIST(state, selected) {
      state.categorys = selected;
    },
    SET_LATLNG(state, latlng) {
      state.latlng.lat = latlng.lat;
      state.latlng.lng = latlng.lng;
    },
    SET_CONCERNLATLNG(state, latlng) {
      state.concernlatlng.lat = latlng.lat;
      state.concernlatlng.lng = latlng.lng;
    },
    CLEAR_CATEGORYSRESULT_LIST(state) {
      state.categorysresult = {
        MT1: null,
        CS2: null,
        PS3: null,
        SC4: null,
        AC5: null,
        PK6: null,
        OL7: null,
        SW8: null,
        BK9: null,
        CT1: null,
        AG2: null,
        PO3: null,
        AT4: null,
        AD5: null,
        FD6: null,
        CE7: null,
        HP8: null,
        PM9: null,
      };
    },
    SET_CATEGORYSRESULT_LIST(state, category) {
      state.categorysresult[category.code] = category.resultlist;
    },
    //////////////// concern start ////////////////////////
    CLEAR_CHECK_CONCERN(state) {
      state.checkconcern = false;
    },
    CHECK_CONCERN(state, bool) {
      state.checkconcern = bool;
    },
    CLEAR_CONCERN_LIST(state) {
      state.concerns = [];
    },
    SET_CONCERN_LIST(state, concerns) {
      state.concerns = concerns;
    },
    //////////////// concern end //////////////////////////
    CLEAR_APT_DEAL_HISTORY_LIST(state) {
      state.aptDealHistroy = [];
    },
    SET_APT_DEAL_HISTORY_LIST(state, aptDealHistroy) {
      state.aptDealHistroy = aptDealHistroy;
    },
    CLEAR_APT_DEALYEAR(state) {
      state.aptDealyear = [];
    },
    SET_APT_DEALYEAR(state, data) {
      state.aptDealyear = data;
    },
    CLEAR_APT_DEALYEAR_CONCERN(state) {
      state.aptDealyearConcern = [];
    },
    SET_APT_DEALYEAR_CONCERN(state, data) {
      state.aptDealyearConcern = data;
    },
  },
  actions: {
    getSido: ({ commit }) => {
      sidoList(
        ({ data }) => {
          commit("SET_SIDO_LIST", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },
    getGugun: ({ commit }, sidoCode) => {
      const params = { sidoCode: sidoCode };
      gugunList(
        params,
        ({ data }) => {
          commit("SET_GUGUN_LIST", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },
    getDong: ({ commit }, gugunCode) => {
      const params = { gugunCode: gugunCode };
      dongList(
        params,
        ({ data }) => {
          commit("SET_DONG_LIST", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },

    setSido: ({ commit }, data) => {
      commit("SET_SIDO", data);
    },
    setGugun: ({ commit }, data) => {
      commit("SET_GUGUN", data);
    },
    setDong: ({ commit }, data) => {
      commit("SET_DONG", data);
    },
    setDongCode: ({ commit }, data) => {
      commit("SET_DONGCODE", data);
    },

    removeHouseList: ({ commit }) => {
      commit("SET_SEARCHTYPE", null);
      commit("SET_SIDO", null);
      commit("SET_GUGUN", null);
      commit("SET_DONG", null);
      commit("SET_HOUSE_LIST", []);
    },

    // 아파트 정보
    getHouseList: ({ commit }, payload) => {
      const params = {
        code: payload.dongCode,
        year: payload.year,
        month: payload.month,
      };
      houseList(
        params,
        ({ data }) => {
          commit("SET_SEARCHTYPE", "APT");
          commit("SET_SIDO", payload.sido);
          commit("SET_GUGUN", payload.gugun);
          commit("SET_DONG", payload.dong);
          commit("SET_HOUSE_LIST", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },

    // 연립다세대 주택 정보
    getMultiHouseList: ({ commit }, payload) => {
      // const SERVICE_KEY = process.env.VUE_APP_APT_DEAL_API_KEY;
      const params = {
        //LAWD_CD: payload.dongCode.substr(0, 5),
        // DEAL_YMD: payload.year + payload.month,
        // serviceKey: decodeURIComponent(SERVICE_KEY),
        code: payload.dongCode.substr(0, 5),
        dealYM: payload.year + payload.month,
      };
      multihouseList(
        params,
        ({ data }) => {
          commit("SET_SEARCHTYPE", "MULTIHOUSE");
          commit("SET_SIDO", payload.sido);
          commit("SET_GUGUN", payload.gugun);
          commit("SET_DONG", payload.dong);
          commit("SET_MULTIHOUSE_LIST", data.response.body.items.item);
        },
        (error) => {
          console.log(error);
        },
      );
    },
    getHouseOneList({ commit }, house) {
      commit("SET_HOUSE_LIST", house);
    },

    detailHouse({ commit }, house) {
      commit("SET_DETAIL_HOUSE", house);
    },
    /////////////////////////////// Date start ////////////////////////////////////
    getYear({ commit }) {
      commit("SET_YEAR_LIST");
    },
    getMonth({ commit }, year) {
      commit("SET_MONTH_LIST", year);
    },
    /////////////////////////////// Date end /////////////////////////////////////

    setMapLatLng({ commit }, latlng) {
      commit("SET_LATLNG", latlng);
    },
    getSearchCategoryList({ commit }, payload) {
      if (
        payload.selected.length == 0 ||
        typeof payload.category == "undefined" ||
        payload.category.length == 0 ||
        payload.category === null
      ) {
        commit("SET_CATEGORY_LIST", payload.selected);
        return;
      }

      const params = {
        category_group_code: payload.category[0],
        y: payload.latlng.lat,
        x: payload.latlng.lng,
        radius: 2000,
      };

      searchCategoryList(
        params,
        ({ data }) => {
          const category = {
            code: params.category_group_code,
            resultlist: data.documents,
          };
          commit("SET_CATEGORYSRESULT_LIST", category);
          commit("SET_CATEGORY_LIST", payload.selected);
        },
        (error) => {
          console.log(error);
        },
      );
    },

    //////////////// concern start ////////////////////////
    getCheckConcern({ commit }, payload) {
      ckConcern(
        payload.userId,
        payload.dongCode,
        ({ data }) => {
          if (data.message === "success") {
            console.log("관심지역 O");
            commit("CHECK_CONCERN", true);
          } else {
            console.log("관심지역 X");
            commit("CHECK_CONCERN", false);
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    registerConcern({ commit }, payload) {
      registerConcern(
        payload,
        ({ status }) => {
          switch (status) {
            case 200:
              commit("CHECK_CONCERN", true);
              break;
            case 204:
              alert("관심지역 등록에 실패하였습니다.");
              break;

            default:
              break;
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    deleteConcern({ commit }, payload) {
      deleteConcern(
        payload.userId,
        payload.dongCode,
        ({ status }) => {
          switch (status) {
            case 200:
              commit("CHECK_CONCERN", false);
              if (payload.callback()) payload.callback();
              break;
            case 204:
              alert("관심지역 삭제에 실패하였습니다.");
              break;

            default:
              break;
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },

    // 관심 지역 목록 불러오기
    getConcernList({ commit }, payload) {
      getConcernList(
        payload.userId,
        ({ data }) => {
          commit("SET_CONCERN_LIST", data);
          payload.callback(); // 관심 지역에 따른 차트 불러오기
        },
        (error) => {
          console.log(error);
        },
      );
    },

    getRecentConcernList({ commit }, payload) {
      commit("SET_CONCERN_LIST", payload.concerns);
    },
    //////////////// concern end ////////////////////////
    async getAptDealHistroy({ commit }, payload) {
      await getAptDealHistroy(
        payload.aptCode,
        ({ data }) => {
          commit("SET_APT_DEAL_HISTORY_LIST", data);
        },
        (error) => {
          console.log(error);
        },
      );
      payload.callback();
    },

    async getAptDealyear({ commit }) {
      await getAptDealyear(
        ({ data }) => {
          commit("SET_APT_DEALYEAR", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },
    async getAptDealyearConcern({ commit }, payload) {
      await getAptDealyearConcern(
        payload.concerns,
        ({ data }) => {
          commit("SET_APT_DEALYEAR_CONCERN", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },

    searchAddress({ commit }, payload) {
      const params = {
        query: payload.query,
      };
      searchAddress(
        params,
        ({ data }) => {
          data = data.documents.filter(function (e) {
            return e.address.b_code.length !== 0;
          });

          const latlng = {
            lat: data[0].y,
            lng: data[0].x,
          };

          commit("SET_CONCERNLATLNG", latlng);
          commit("SET_CONCERN_DONGCODE", data[0].address.b_code);
        },
        (error) => {
          console.log(error);
        },
      );
    },
  },
};

export default houseStore;
