<template>
  <div class="fixed-top">
    <b-navbar toggleable="lg" class="px-lg-5 px-2 py-2 bg-white" id="navbar">
      <b-navbar-brand href="#">
        <router-link to="/" id="logo">
          <img
            src="@/assets/img/logo5.png"
            class="d-inline-block align-middle"
            width="150px"
            alt="Kitten" />
        </router-link>
      </b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav class="ml-auto">
          <b-nav-item href="#"
            ><router-link :to="{ name: 'house' }" class="link"
              >지도</router-link
            ></b-nav-item
          >
          <b-nav-item href="#"
            ><router-link to="/" class="link">공지사항</router-link></b-nav-item
          >
          <b-nav-item href="#"
            ><router-link :to="{ name: 'QnA' }" class="link">
              QnA
            </router-link></b-nav-item
          >
          <b-nav-item v-if="userInfo != null">
            <router-link to="/concern" class="link">관심목록</router-link>
          </b-nav-item>
          <b-nav-item v-if="userInfo != null"
            >{{ userInfo.userId }}({{ userInfo.userName }})님
          </b-nav-item>
          <b-nav-item href="#" v-if="userInfo != null"
            ><router-link :to="{ name: 'user' }" class="link">
              프로필
            </router-link></b-nav-item
          >
          <b-nav-item
            v-if="userInfo != null"
            @click.prevent="onClickLogout"
            class="link"
            >로그아웃</b-nav-item
          >
          <b-nav-item href="#" v-else
            ><router-link to="" class="link" v-b-modal.join-modal
              >회원가입</router-link
            ></b-nav-item
          >
          <b-nav-item href="#" v-if="userInfo == null">
            <router-link to="" class="link" v-b-modal.login-modal
              >로그인</router-link
            ></b-nav-item
          >

          <b-modal
            id="join-modal"
            hide-header
            hide-footer
            centered
            title="회원가입">
            <user-join />
          </b-modal>
          <b-modal
            hide-header
            hide-footer
            id="login-modal"
            centered
            title="로그인">
            <user-login />
          </b-modal>
          <b-modal
            hide-header
            hide-footer
            id="find-modal"
            centered
            title="비밀번호 찾기">
            <find-pwd />
          </b-modal>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
import { mapState, mapGetters, mapActions } from "vuex";
import UserLogin from "@/components/user/UserLogin.vue";
import UserJoin from "@/components/user/UserRegister.vue";
import FindPwd from "@/components/user/FindPwd.vue";

const memberStore = "memberStore";
export default {
  name: "NaviBar",
  components: {
    UserLogin,
    UserJoin,
    FindPwd,
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
    ...mapGetters(["checkUserInfo"]),
  },
  methods: {
    ...mapActions(memberStore, ["userLogout"]),
    // ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      console.log(this.userInfo.userid);
      this.userLogout(this.userInfo.userid);
      sessionStorage.removeItem("access-token"); //저장된 토큰 없애기
      sessionStorage.removeItem("refresh-token"); //저장된 토큰 없애기
      if (this.$route.path != "/") this.$router.push({ name: "HomeView" });
    },
  },
};
</script>

<style>
@import "../../assets/css/main.css";
.modal-content {
  border-radius: 25px !important;
  border: none !important;
}
</style>
