import jwtDecode from "jwt-decode";
import router from "@/router";
import {
  login,
  findById,
  tokenRegeneration,
  logout,
  checkId,
  joinUser,
  editUser,
  delUser,
  getUsers,
  adminDelUser,
  sendEmail,
  getCountQ,
  getCountC,
} from "@/api/member";

const memberStore = {
  namespaced: true,
  state: {
    isLogin: false,
    isLoginError: false,
    userInfo: null,
    isValidToken: false,
    idUseable: false,
    users: [],
    countQ: 0,
    countC: 0,
  },
  getters: {
    checkUserInfo: function (state) {
      return state.userInfo;
    },
    checkToken: function (state) {
      return state.isValidToken;
    },
  },
  mutations: {
    ID_USEABLE: (state, idUseable) => {
      state.idUseable = idUseable;
    },
    SET_IS_LOGIN: (state, isLogin) => {
      state.isLogin = isLogin;
    },
    SET_IS_LOGIN_ERROR: (state, isLoginError) => {
      state.isLoginError = isLoginError;
    },
    SET_IS_VALID_TOKEN: (state, isValidToken) => {
      state.isValidToken = isValidToken;
    },
    SET_USER_INFO: (state, userInfo) => {
      state.isLogin = true;
      state.userInfo = userInfo;
    },
    SET_USERS: (state, users) => {
      state.users = users;
    },
    SET_COUNT_Q: (state, countQ) => {
      state.countQ = countQ;
    },
    SET_COUNT_C: (state, countC) => {
      state.countC = countC;
    },
  },
  actions: {
    async userConfirm({ commit }, user) {
      await login(
        user,
        ({ data }) => {
          if (data.message === "success") {
            let accessToken = data["access-token"];
            let refreshToken = data["refresh-token"];
            // console.log("login success token created!!!! >> ", accessToken, refreshToken);
            commit("SET_IS_LOGIN", true);
            commit("SET_IS_LOGIN_ERROR", false);
            commit("SET_IS_VALID_TOKEN", true);
            sessionStorage.setItem("access-token", accessToken);
            sessionStorage.setItem("refresh-token", refreshToken);
          } else {
            commit("SET_IS_LOGIN", false);
            commit("SET_IS_LOGIN_ERROR", true);
            commit("SET_IS_VALID_TOKEN", false);
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    async idConfirm({ commit }, id) {
      await checkId(
        id,
        ({ data }) => {
          if (data.message === "success") {
            console.log("성공");
            commit("ID_USEABLE", true);
          } else {
            console.log("실패");
            commit("ID_USEABLE", false);
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    // 비밀번호 찾기
    async findPw({ commit }, payload) {
      console.log(payload.email + "비번 보낼 이메일~~~");
      await sendEmail(payload.email, ({ data }) => {
        console.log(commit);
        console.log(data.message);
        console.log(this);
        if (data.message === "success") {
          payload.callback1();
        } else {
          payload.callback2();
        }
      });
    },
    async addUser({ commit }, payload) {
      console.log(commit);
      console.log("가입했을 시" + payload);
      await joinUser(payload.user, ({ data }) => {
        if (data.message === "success") {
          alert("회원가입 성공!");
          if (payload.callback) payload.callback();
          console.log("성공");
        } else {
          alert("회원가입에 실패하셨습니다.");
          console.log("실패");
        }
      });
    },
    async editUser({ commit }, payload) {
      console.log(commit);
      await editUser(payload.user, ({ data }) => {
        if (data.message === "success") {
          payload.callback();
          if (!payload.admin) {
            commit("SET_USER_INFO", data.userInfo);
          }
        } else {
          console.log("유저 정보 없음!!!!");
        }
      });
    },
    async getUserInfo({ commit, dispatch }, token) {
      let decodeToken = jwtDecode(token);
      console.log(decodeToken);
      // console.log("2. getUserInfo() decodeToken :: ", decodeToken);
      await findById(
        decodeToken.userId,
        ({ data }) => {
          if (data.message === "success") {
            commit("SET_USER_INFO", data.userInfo);
          } else {
            console.log("유저 정보 없음!!!!");
          }
        },
        async (error) => {
          console.log(
            "getUserInfo() error code [토큰 만료되어 사용 불가능.] ::: ",
            error.response.status,
          );
          await dispatch("tokenRegeneration");
        },
      );
    },
    async tokenRegeneration({ commit, state }) {
      console.log(
        "토큰 재발급 >> 기존 토큰 정보 : {}",
        sessionStorage.getItem("access-token"),
      );
      await tokenRegeneration(
        JSON.stringify(state.userInfo),
        ({ data }) => {
          if (data.message === "success") {
            let accessToken = data["access-token"];
            console.log("재발급 완료 >> 새로운 토큰 : {}", accessToken);
            sessionStorage.setItem("access-token", accessToken);
            commit("SET_IS_VALID_TOKEN", true);
          } else {
            commit("SET_USER_INFO", null);
            commit("SET_IS_VALID_TOKEN", false);
            commit("SET_IS_LOGIN", false);
          }
        },
        async (error) => {
          // HttpStatus.UNAUTHORIZE(401) : RefreshToken 기간 만료 >> 다시 로그인!!!!
          if (error.response.status === 401) {
            console.log("갱신 실패");
            // 다시 로그인 전 DB에 저장된 RefreshToken 제거.
            await logout(
              state.userInfo.userId,
              ({ data }) => {
                if (data.message === "success") {
                  console.log("리프레시 토큰 제거 성공");
                } else {
                  console.log("리프레시 토큰 제거 실패");
                }
                alert("RefreshToken 기간 만료!!! 다시 로그인해 주세요.");
                commit("SET_IS_LOGIN", false);
                commit("SET_USER_INFO", null);
                commit("SET_IS_VALID_TOKEN", false);
                router.push({ name: "login" });
              },
              (error) => {
                console.log(error);
                commit("SET_IS_LOGIN", false);
                commit("SET_USER_INFO", null);
              },
            );
          }
        },
      );
    },
    async deleteUser({ commit }, userId) {
      await delUser(
        userId,
        ({ data }) => {
          if (data.message === "success") {
            commit("SET_IS_LOGIN", false);
            commit("SET_USER_INFO", null);
            commit("SET_IS_VALID_TOKEN", false);
          } else {
            console.log("유저 정보 없음!!!!");
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    async adminDeleteUser({ commit }, payload) {
      console.log(commit);
      await adminDelUser(
        payload.userId,
        (response) => {
          switch (response.status) {
            case 200:
              payload.callback();
              console.log("toast 띄우기 성공!");
              break;
            case 204:
            case 500:
              console.log("toast : 실패");
              break;
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    async userLogout({ commit }, userId) {
      await logout(
        userId,
        ({ data }) => {
          if (data.message === "success") {
            commit("SET_IS_LOGIN", false);
            commit("SET_USER_INFO", null);
            commit("SET_IS_VALID_TOKEN", false);
          } else {
            console.log("유저 정보 없음!!!!");
          }
        },
        (error) => {
          console.log(error);
        },
      );
    },
    async getUsers({ commit }) {
      await getUsers(({ data }) => {
        commit("SET_USERS", data);
        console.log("list:" + data);
      });
    },
    async getCountQ({ commit }, userId) {
      await getCountQ(
        userId,
        ({ data }) => {
          commit("SET_COUNT_Q", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },
    async getCountC({ commit }, userId) {
      await getCountC(
        userId,
        ({ data }) => {
          commit("SET_COUNT_C", data);
        },
        (error) => {
          console.log(error);
        },
      );
    },
  },
};

export default memberStore;
