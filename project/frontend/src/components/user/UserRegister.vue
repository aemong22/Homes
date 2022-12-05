<template>
  <b-container class="my-3 px-4 text-center">
    <b-row>
      <b-col>
        <img
          src="@/assets/img/logo4.png"
          class="d-inline-block align-middle"
          width="150px"
          alt="Kitten" />
      </b-col>
    </b-row>

    <b-form-group label-for="userId">
      <b-input
        id="userId"
        ref="userId"
        class="joinform"
        v-model="user.userId"
        required
        placeholder="ID"
        @keyup="checkId" />
      <div id="idcheck-result"></div>
    </b-form-group>
    <b-form-group label-for="userPwd">
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
    <b-form-group label-for="userName">
      <b-input
        id="userName"
        class="joinform"
        ref="userName"
        v-model="user.userName"
        required
        placeholder="NAME"
        @keyup.enter="confirm" />
    </b-form-group>
    <b-form-group label-for="address">
      <b-input
        id="address"
        ref="address"
        v-model="user.address"
        class="joinform"
        required
        placeholder="ADDRESS"
        @keyup.enter="confirm" />
    </b-form-group>
    <b-input-group label-for="address" class="mb-3">
      <b-form-input
        type="text"
        id="emailId"
        v-model="user.emailId"
        ref="emailId"
        class="joinform"
        placeholder="이메일아이디"
        required />
      <span class="input-group-text">@</span>
      <b-form-select
        id="emailDomain"
        name="emailDomain"
        class="joinform"
        ref="emailDomain"
        v-model="user.emailDomain"
        :options="options">
      </b-form-select>
    </b-input-group>
    <b-form-group label-for="phonenumber">
      <b-input
        id="phonenumber"
        ref="phonenumber"
        class="joinform"
        v-model="user.phonenumber"
        required
        placeholder="PHONE-NUMBER"
        @keyup.enter="confirm" />
    </b-form-group>
    <div
      v-if="type != 'admin'"
      type="button"
      variant="primary"
      id="joinBtn"
      class="my-1 p-2 confirmBtn"
      @click="joinUser">
      회원가입
    </div>
    <div
      v-else
      type="button"
      variant="primary"
      id="joinBtn"
      class="my-1 p-2 confirmBtn"
      @click="joinUser">
      회원 등록
    </div>
    <div v-if="type != 'admin'">
      <div class="hr-sect">or</div>
      <div class="d-flex justify-content-center" style="font-size: 14px">
        <div class="text-muted">이미 계정이 있으신가요?</div>
        <div
          type="button"
          variant="success"
          id="loginBtn"
          size="sm"
          class="mx-2 anotherBtn"
          @click="loginModalOpen">
          로그인
        </div>
      </div>
    </div>
  </b-container>
</template>

<script>
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";

export default {
  props: {
    // 부모 component로 부터 전달받은 type 정보를 받아옴
    type: { type: String },
  },
  name: "UserRegister",
  data() {
    return {
      // isLoginError: false,
      user: {
        userId: null,
        userPwd: null,
        userName: null,
        emailId: null,
        emailDomain: null,
        phonenumber: null,
        address: null,
      },
      isUseId: false,
      options: [
        { value: null, text: "선택" },
        { value: "ssafy.com", text: "ssafy.com" },
        { value: "google.com", text: "google.com" },
        { value: "naver.com", text: "naver.com" },
      ],
    };
  },
  computed: {
    ...mapState(memberStore, ["idUseable"]),
  },
  methods: {
    ...mapActions(memberStore, ["idConfirm", "addUser", "getUsers"]),
    async checkId() {
      let userid = this.user.userId;
      let resultDiv = document.querySelector("#idcheck-result");
      if (userid.length < 5 || userid.length > 16) {
        resultDiv.setAttribute("class", "m-1 text-danger");
        resultDiv.textContent = "아이디는 5자 이상 16자 이하 입니다.";
        this.isUseId = false;
      } else {
        await this.idConfirm(userid);
        if (this.idUseable) {
          this.isUseId = true;
          resultDiv.textContent = "사용가능한 아이디입니다.";
          resultDiv.setAttribute("class", "m-1 text-info");
        } else {
          this.isUseId = false;
          resultDiv.textContent = "사용 불가능한 아이디입니다.";
        }
      }
    },
    async joinUser() {
      let isValid = true;
      let errMsg = "";
      !this.user.userId
        ? ((isValid = false),
          (errMsg = "아이디을 입력해주세요."),
          this.$refs.userId.focus())
        : !this.user.userPwd
        ? ((isValid = false),
          (errMsg = "비밀번호를 입력해주세요."),
          this.$refs.userPwd.focus())
        : !this.user.userName
        ? ((isValid = false),
          (errMsg = "이름를 입력해주세요."),
          this.$refs.userName.focus())
        : !this.user.address
        ? ((isValid = false),
          (errMsg = "주소를 입력해주세요."),
          this.$refs.address.focus())
        : !this.user.emailId && !this.user.emailDomain
        ? ((isValid = false),
          (errMsg = "이메일을 입력해주세요."),
          this.$refs.emailId.focus())
        : !this.user.phonenumber
        ? ((isValid = false),
          (errMsg = "전화번호를 입력해주세요."),
          this.$refs.phonenumber.focus())
        : !this.isUseId
        ? ((errMsg = "아이디를 확인해주세요"), this.$ref.userId.focus())
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
        console.log(this.user);
        console.log(this.type);
        if (this.type != "admin") {
          const payload = {
            user: this.user,
            callback: () => {
              this.loginModalOpen();
            },
          };
          console.log("admin이 아닐때");
          await this.addUser(payload);
        } else {
          const payload = {
            user: this.user,
            callback: () => {
              this.getUsers();
              this.$bvModal.hide("admin-join-modal");
            },
          };
          console.log("admin 일 때");
          await this.addUser(payload);
        }
      }
    },
    loginModalOpen() {
      this.$bvModal.hide("join-modal");
      this.$bvModal.show("login-modal");
    },
  },
};
</script>

<style></style>
