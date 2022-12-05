<template>
  <b-container class="text-center px-4 my-3">
    <div>
      <img
        src="@/assets/img/logo4.png"
        class="d-inline-block align-middle"
        width="150px"
        alt="Kitten" />
    </div>
    <b-form class="text-left">
      <b-alert show variant="warning" v-if="isLoginError"
        >아이디 또는 비밀번호를 확인하세요.</b-alert
      >
      <b-form-group label-for="userId">
        <b-input
          id="userId"
          v-model="user.userId"
          class="joinform"
          required
          placeholder="ID"
          @keyup.enter="confirm" />
      </b-form-group>
      <b-form-group label-for="userPwd">
        <b-input
          type="password"
          id="userPwd"
          class="joinform"
          v-model="user.userPwd"
          required
          placeholder="PASSWORD"
          @keyup.enter="confirm"></b-input>
      </b-form-group>
      <div type="button" class="my-1 p-2 confirmBtn" @click="confirm">
        로그인
      </div>
      <div class="hr-sect">or</div>
      <div class="d-flex justify-content-center" style="font-size: 14px">
        <div class="text-muted">계정이 없으신가요?</div>
        <div
          type="button"
          variant="success"
          id="joinBtn"
          size="sm"
          class="mx-2 anotherBtn"
          @click="joinModalOpen">
          회원가입
        </div>
      </div>
      <div class="d-flex justify-content-center" style="font-size: 14px">
        <div class="text-muted">비밀번호를 잊으셨나요?</div>
        <div
          type="button"
          variant="success"
          id="joinBtn"
          size="sm"
          class="mx-2 anotherBtn"
          @click="findPwd">
          비밀번호 찾기
        </div>
      </div>
    </b-form>
  </b-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";

export default {
  name: "UserLogin",
  data() {
    return {
      // isLoginError: false,
      user: {
        userId: null,
        userPwd: null,
      },
    };
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "isLoginError", "userInfo"]),
  },
  methods: {
    ...mapActions(memberStore, ["userConfirm", "getUserInfo"]),
    async confirm() {
      await this.userConfirm(this.user);
      let token = sessionStorage.getItem("access-token");
      // console.log("1. confirm() token >> " + token);
      if (this.isLogin) {
        console.log("로그인한 사용자 정보" + token);
        await this.getUserInfo(token);
        // console.log("4. confirm() userInfo :: ", this.userInfo);
        // this.$router.push({ name: "HomeView" });
        this.$bvModal.hide("login-modal");
      }
    },
    joinModalOpen() {
      this.$bvModal.hide("login-modal");
      this.$bvModal.show("join-modal");
    },
    findPwd() {
      this.$bvModal.hide("login-modal");
      this.$bvModal.show("find-modal");
    },
  },
};
</script>

<style scoped></style>
