<template>
  <b-row>
    <b-col cols="12">
      <hr class="my-4" />
      <b-container class="mt-4">
        <b-row class="mb-1">
          <b-col cols="3"></b-col>
          <b-col cols="2">아이디</b-col
          ><b-col cols="5" align-self="start">{{ userInfo.userId }}</b-col>
          <b-col cols="1"></b-col>
        </b-row>
        <b-row class="mb-1">
          <b-col cols="3"></b-col>
          <b-col cols="2">이름</b-col
          ><b-col cols="5" align-self="start">{{ userInfo.userName }}</b-col>
          <b-col cols="1"></b-col>
        </b-row>
        <b-row class="mb-1">
          <b-col cols="3"></b-col>
          <b-col cols="2">이메일</b-col
          ><b-col cols="5" align-self="start">
            {{ userInfo.emailId }} @ {{ userInfo.emailDomain }}
          </b-col>
          <b-col cols="1"></b-col>
        </b-row>
        <b-row class="mb-1">
          <b-col cols="3"></b-col>
          <b-col cols="2">주소</b-col
          ><b-col cols="5" align-self="start">{{ userInfo.address }}</b-col>
          <b-col cols="1"></b-col>
        </b-row>
        <b-row>
          <b-col cols="3"></b-col>
          <b-col cols="2">전화번호</b-col
          ><b-col cols="5" align-self="start">
            {{ userInfo.phonenumber }}
          </b-col>
          <b-col cols="1"></b-col>
        </b-row>
      </b-container>
      <hr class="my-4" />
    </b-col>
  </b-row>
</template>

<script>
import { mapState } from "vuex";

const memberStore = "memberStore";

export default {
  name: "UserMyPage",
  components: {},
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
  },
  created() {
    console.log(this.userInfo);
  },
};
</script>

<style scoped>
a {
  color: white;
  text-decoration: none;
}
</style>
