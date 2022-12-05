<template>
  <div class="box p-3">
    <b-input-group>
      <b-form-textarea
        placeholder="댓글을 입력해주세요."
        rows="3"
        max-rows="6"
        v-model="comment"
        class="comment_write"></b-form-textarea>
      <b-input-group-append>
        <b-button variant="secondary" @click="write">등록</b-button>
      </b-input-group-append>
    </b-input-group>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapState } from "vuex";
const memberStore = "memberStore";
export default {
  props: {
    qnaNo: Number,
  },
  data() {
    return {
      userId: "",
      comment: "",
    };
  },
  methods: {
    ...mapActions(["createComment", "getComments"]),
    write() {
      console.log("댓글 추가할 qna_no" + this.qnaNo);
      const payload = {
        comment: {
          qnaNo: this.qnaNo,
          userId: this.userInfo.userId,
          comment: this.comment,
        },
        callback: () => {
          // 기존 입력한 내용 지우기
          this.userId = "";
          this.comment = "";

          // 서버에 입력한 내용이 포함된 댓글 목록 요청하기
          this.getComments(this.qnaNo);

          // Bootstrap Vue를 이용하여 메시지 출력(Toast)
          this.$toast.success("댓글이 등록되었습니다.", {
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

      this.createComment(payload);
    },
  },
  computed: {
    ...mapGetters(["qna"]),
    ...mapState(memberStore, ["userInfo"]),
  },
};
</script>

<style scoped></style>
