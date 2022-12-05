<template>
  <b-list-group-item class="flex-column align-items-start">
    <div class="d-flex w-100 justify-content-between">
      <div class="mb-2 comment_user">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24">
          <path
            d="M12 2a5 5 0 1 0 5 5 5 5 0 0 0-5-5zm0 8a3 3 0 1 1 3-3 3 3 0 0 1-3 3zm9 11v-1a7 7 0 0 0-7-7h-4a7 7 0 0 0-7 7v1h2v-1a5 5 0 0 1 5-5h4a5 5 0 0 1 5 5v1z"></path>
        </svg>
        {{ comment.userId }}
      </div>
      <small class="text-muted">{{ comment.commentTime }}</small>
    </div>

    <p :inner-html.prop="comment.comment | filterEnterToBr"></p>

    <div class="text-right">
      <b-button-group v-if="comment.userId == this.userInfo.userId">
        <b-button variant="secondary" @click="showModalModify">수정</b-button>
        <b-button variant="outline-secondary" @click="showModalDelete"
          >삭제</b-button
        >
      </b-button-group>
    </div>

    <!-- 수정 모달 창 작성 -->
    <b-modal
      :ref="`comment-${comment.commentNo}`"
      title="댓글 수정"
      header-bg-variant="dark"
      header-text-variant="light"
      centered
      hide-footer>
      <!-- 수정 모달 창 Body 작성 -->
      <div>
        <b-form-textarea
          v-model="input.comment"
          placeholder="댓글 입력..."
          rows="3"
          max-rows="6"></b-form-textarea>
      </div>

      <!-- 수정 모달 창 Footer 작성 -->
      <div class="text-right">
        <b-button-group>
          <b-button variant="outline-secondary">취소</b-button>
          <b-button variant="secondary" @click="modify">수정</b-button>
        </b-button-group>
      </div>
    </b-modal>
  </b-list-group-item>
</template>

<script>
import { mapActions, mapState } from "vuex";
const memberStore = "memberStore";

export default {
  props: {
    qnaNo: Number,
    comment: Object,
  },
  methods: {
    ...mapActions(["modifyComment", "getComments", "deleteComment"]),
    showModalModify() {
      this.$refs[`comment-${this.comment.commentNo}`].show();
    },
    hideModalModify() {
      this.$refs[`comment-${this.comment.commentNo}`].hide();
    },
    modify() {
      const payload = {
        comment: {
          commentNo: this.comment.commentNo,
          comment: this.input.comment,
        },
        callback: () => {
          // 수정한 내용 지우기
          this.input.userName = "";
          this.input.comment = "";

          // 댓글 목록 갱신하기
          this.getComments(this.qnaNo);

          // 모달창 숨기기
          this.hideModalModify();

          // 수정 완료 Toast 출력
          this.$toast.info("댓글이 수정되었습니다.", {
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

      this.modifyComment(payload);
    },
    showModalDelete() {
      this.$fire({
        title: "Confirm",
        text: "정말로 삭제 하시겠습니까",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes",
      }).then((result) => {
        if (result.value) {
          this.delete();
        }
      });
    },
    delete() {
      const payload = {
        commentNo: this.comment.commentNo,
        callback: () => {
          // 댓글 목록 갱신
          this.getComments(this.qnaNo);

          // 삭제 완료 Toast 출력
          this.$toast.info("댓글이 삭제되었습니다.", {
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

      this.deleteComment(payload);
    },
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    input() {
      return { ...this.comment }; // Vuex의 state.comments 객체에 직접 접근하는걸 막기 위해 Deep Copy
    },
  },
};
</script>

<style></style>
