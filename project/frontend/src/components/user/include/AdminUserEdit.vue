<template>
  <b-container>
    <b-form-group
      label-for="userId"
      label="ID"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm="10"
      content-cols-lg="10">
      <b-form-input
        id="userId"
        ref="userId"
        class="joinform"
        disabled
        v-model="user.userId"
        placeholder="ID" />
    </b-form-group>
    <b-form-group
      label="PASSWORD"
      label-for="userPwd"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="10">
      <b-input
        type="password"
        class="joinform"
        id="userPwd"
        ref="userPwd"
        v-model="user.userPwd"
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
      content-cols-lg="10"
      label-for="userName">
      <b-input
        id="userName"
        class="joinform"
        ref="userName"
        required
        v-model="user.userName"
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
      content-cols-lg="10">
      <b-input
        id="address"
        ref="address"
        class="joinform"
        required
        v-model="user.address"
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
      content-cols-lg="10">
      <b-input-group>
        <b-form-input
          type="text"
          id="emailId"
          ref="emailId"
          class="joinform"
          v-model="user.emailId"
          placeholder="이메일아이디"
          required />
        <b-input-group-text>@</b-input-group-text>
        <b-form-select
          id="emailDomain"
          name="emailDomain"
          class="joinform"
          v-model="user.emailDomain"
          ref="emailDomain"
          :options="options">
        </b-form-select>
      </b-input-group>
    </b-form-group>
    <b-form-group
      label-for="phonenumber"
      label="PHONE"
      label-align-sm="right"
      label-cols-sm="2"
      label-cols-lg="2"
      content-cols-sm
      content-cols-lg="10">
      <b-input
        id="phonenumber"
        ref="phonenumber"
        class="joinform"
        v-model="user.phonenumber"
        required
        placeholder="PHONE-NUMBER" />
    </b-form-group>
    <b-row align-h="center">
      <b-button class="d-block mx-1" variant="success" @click="validate"
        >프로필 수정</b-button
      >
      <b-button class="d-block" variant="primary" @click="moveList">
        취소
      </b-button>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions } from "vuex";
const memberStore = "memberStore";

export default {
  props: {
    userId: String,
    userPwd: String,
    userName: String,
    address: String,
    emailId: String,
    emailDomain: String,
    phonenumber: String,
  },
  data() {
    return {
      user: this.$props ? { ...this.$props } : {},
      options: [
        { value: null, text: "선택" },
        { value: "ssafy.com", text: "ssafy.com" },
        { value: "google.com", text: "google.com" },
        { value: "naver.com", text: "naver.com" },
      ],
    };
  },
  methods: {
    ...mapActions(memberStore, ["editUser", "getUsers"]),
    validate() {
      let isValid = true;
      let errMsg = "";
      !this.user.userPwd
        ? ((isValid = false),
          (errMsg = "비밀번호를 입력해주세요."),
          this.$refs.userPwd.focus())
        : !this.user.userName
        ? ((isValid = false),
          (errMsg = "이름을 입력해주세요."),
          this.$refs.userName.focus())
        : !this.user.address
        ? ((isValid = false),
          (errMsg = "주소를 입력해주세요."),
          this.$refs.address.focus())
        : !this.user.emailId
        ? ((isValid = false),
          (errMsg = "이메일을 입력해주세요."),
          this.$refs.emailId.focus())
        : !this.user.emailDomain
        ? ((isValid = false),
          (errMsg = "이메일을 입력해주세요."),
          this.$refs.emailDomain.focus())
        : !this.user.phonenumber
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
          user: this.user,
          admin: true,
          callback: () => {
            this.getUsers();
            this.$bvModal.hide(this.user.userId);
          },
        };
        this.editUser(payload);
        this.moveList();
      }
    },
    moveList() {
      this.$bvModal.hide(this.user.userId);
    },
  },
};
</script>

<style></style>
