<!-- eslint-disable vue/no-computed-properties-in-data -->
<template>
  <b-container class="p-2 mt-3">
    <b-col cols="1"></b-col>
    <b-form-group
      label-for="userId"
      label="ID"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="8">
      <b-form-input
        id="userId"
        ref="userId"
        class="joinform"
        v-model="input.userId"
        disabled
        placeholder="ID" />
    </b-form-group>
    <b-form-group
      label="PASSWORD"
      label-for="userPwd"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="8">
      <b-input
        type="password"
        class="joinform"
        id="userPwd"
        ref="userPwd"
        v-model="input.userPwd"
        required
        placeholder="PASSWORD"
        @keyup.enter="confirm"></b-input>
    </b-form-group>
    <b-form-group
      label="NAME"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="8"
      label-for="userName">
      <b-input
        id="userName"
        class="joinform"
        ref="userName"
        v-model="input.userName"
        required
        placeholder="NAME"
        @keyup.enter="confirm" />
    </b-form-group>
    <b-form-group
      label-for="address"
      label="ADDRESS"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="8">
      <b-input
        id="address"
        ref="address"
        v-model="input.address"
        class="joinform"
        required
        placeholder="ADDRESS"
        @keyup.enter="confirm" />
    </b-form-group>
    <b-form-group
      inline
      label-for="emailId"
      label="EMAIL"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="8">
      <b-input-group>
        <b-form-input
          type="text"
          id="emailId"
          v-model="input.emailId"
          ref="emailId"
          class="joinform"
          placeholder="이메일아이디"
          required />
        <b-input-group-text>@</b-input-group-text>
        <b-form-select
          id="emailDomain"
          name="emailDomain"
          class="joinform"
          ref="emailDomain"
          v-model="input.emailDomain"
          :options="options">
        </b-form-select>
      </b-input-group>
    </b-form-group>
    <b-form-group
      label-for="phonenumber"
      label="PHONE NUMBER"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="8">
      <b-input
        id="phonenumber"
        ref="phonenumber"
        class="joinform"
        v-model="input.phonenumber"
        required
        placeholder="PHONE-NUMBER"
        @keyup.enter="confirm" />
    </b-form-group>
    <b-row align-h="center">
      <b-button
        variant="outline-primary"
        size="sm"
        class="m-1"
        @click="validate"
        >수정</b-button
      >
      <b-button
        variant="outline-danger"
        class="m-1"
        size="sm"
        @click="moveList">
        취소
      </b-button>
    </b-row>
  </b-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  data() {
    return {
      options: [
        { value: null, text: "선택" },
        { value: "ssafy.com", text: "ssafy.com" },
        { value: "google.com", text: "google.com" },
        { value: "naver.com", text: "naver.com" },
      ],
    };
  },
  computed: {
    ...mapGetters(memberStore, ["checkUserInfo"]),
    input() {
      return { ...this.checkUserInfo };
    },
  },
  methods: {
    ...mapActions(memberStore, ["editUser"]),
    validate() {
      let isValid = true;
      let errMsg = "";
      !this.input.userPwd
        ? ((isValid = false),
          (errMsg = "비밀번호를 입력해주세요."),
          this.$refs.userPwd.focus())
        : !this.input.userName
        ? ((isValid = false),
          (errMsg = "이름을 입력해주세요."),
          this.$refs.userName.focus())
        : !this.input.address
        ? ((isValid = false),
          (errMsg = "주소를 입력해주세요."),
          this.$refs.address.focus())
        : !this.input.emailId
        ? ((isValid = false),
          (errMsg = "이메일을 입력해주세요."),
          this.$refs.emailId.focus())
        : !this.input.emailDomain
        ? ((isValid = false),
          (errMsg = "이메일을 입력해주세요."),
          this.$refs.emailDomain.focus())
        : !this.input.phonenumber
        ? ((isValid = false),
          (errMsg = "핸드폰 번호를 입력해주세요."),
          this.$refs.phonenumber.focus())
        : (isValid = true);

      if (!isValid) {
        this.$toast.warning(errMsg, {
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
        const payload = {
          user: this.input,
          callback: () => {
            this.$toast.success("회원 수정이 완료되었습니다.", {
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
        this.editUser(payload);
        this.moveList();
      }
    },
    moveList() {
      this.$router.push({ name: "mypage" });
    },
  },
  created() {
    console.log(this.input);
  },
};
</script>

<style></style>
