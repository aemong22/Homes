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
      <b-form-group label-for="userId">
        <b-input
          id="email"
          v-model="email"
          class="joinform"
          required
          placeholder="가입한 이메일을 입력해주세요"
          @keyup.enter="confirm" />
      </b-form-group>

      <div type="button" class="my-1 p-2 confirmBtn" @click="sendEmail">
        비밀번호 찾기
      </div>
    </b-form>
  </b-container>
</template>

<script>
import { mapActions } from "vuex";

const memberStore = "memberStore";

export default {
  data() {
    return {
      email: "",
    };
  },
  methods: {
    ...mapActions(memberStore, ["findPw"]),
    async sendEmail() {
      if (this.email) {
        const payload = {
          email: this.email,
          callback1: () => {
            this.$toast.success("이메일로 비밀번호를 발송하였습니다.", {
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
          callback2: () => {
            this.$toast.warning("잘못된 이메일 입니다.", {
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
        await this.findPw(payload);

        this.$bvModal.hide("find-modal");
        this.$bvModal.show("login-modal");
      } else {
        this.$toast.warning("이메일을 입력해주세요.", {
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

<style scoped></style>
