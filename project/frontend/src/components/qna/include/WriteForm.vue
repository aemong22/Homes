<template>
  <b-container class="bv-example-row mt-3">
    <b-row class="mb-1">
      <b-col class="text-left">
        <b-form>
          <b-form-group
            label-cols="12"
            id="subject-group"
            label="제목"
            label-for="subject"
            description="제목을 입력하세요.">
            <b-form-input
              id="subject"
              ref="subject"
              v-model="input.subject"
              type="text"
              required
              placeholder="제목 입력..." />
          </b-form-group>
          <b-form-group
            label-cols="12"
            id="content-group"
            label="내용"
            label-for="content">
            <b-form-textarea
              id="content"
              v-model="input.content"
              placeholder="내용 입력..."
              rows="10"
              ref="content"
              max-rows="15"></b-form-textarea>
          </b-form-group>

          <b-button
            v-if="type == 'create'"
            variant="primary"
            class="m-1"
            @click="validate"
            >질문 등록</b-button
          >
          <b-button v-else variant="success" class="m-1" @click="validate"
            >질문 수정</b-button
          >
          <b-button variant="primary" class="m-1" @click="moveList"
            >취소</b-button
          >
        </b-form>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapActions, mapGetters, mapState } from "vuex";
const memberStore = "memberStore";

export default {
  props: {
    // 부모 component로 부터 전달받은 type 정보를 받아옴
    type: { type: String },
  },
  methods: {
    ...mapActions(["createQna", "modifyQna"]),
    validate() {
      let isValid = true;
      let errMsg = "";
      this.input.userId = this.userInfo.userId;
      this.input.qnaNo = this.qna.qnaNo ? this.qna.qnaNo : 0;
      !this.input.subject
        ? ((isValid = false),
          (errMsg = "제목을 입력해주세요."),
          this.$refs.subject.focus())
        : !this.input.content
        ? ((isValid = false),
          (errMsg = "내용을 입력해주세요."),
          this.$refs.content.focus())
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
          qna: this.input,
          callback: () => {
            console.log("callback!! 호출", this);
            this.moveList();
          },
        };
        if (this.type == "create") {
          console.log(payload + this.userInfo);
          this.createQna(payload);
        } else {
          this.modifyQna(payload);
        }
      }
    },
    moveList() {
      this.$router.push({ name: "QList" });
    },
  },
  computed: {
    ...mapGetters(["qna"]),
    ...mapState(memberStore, ["userInfo"]),
    input() {
      if (this.type == "modify") {
        // 수정화면일 경우
        return { ...this.qna }; // Vuex의 state.book 객체에 직접 접근하는걸 막기 위해 Deep Copy
      } else {
        // 등록화면일 경우
        return {
          title: "",
          content: "",
        };
      }
    },
  },
};
</script>

<style scoped></style>
