<template>
  <b-card no-body class="qna_card m-0">
    <b-card-header header-tag="header" class="py-3 card_header">
      <b-button
        block
        v-b-toggle="'accordion' + qnaNo"
        variant="light"
        @click="toggle"
        class="qna_header"
        ><b-row
          ><b-col cols="2">No.{{ qnaNo }}</b-col
          ><b-col
            ><strong>{{ title }}</strong></b-col
          ><b-col cols="3">{{ userId }}</b-col></b-row
        ></b-button
      >
    </b-card-header>
    <b-collapse
      :id="'accordion' + qnaNo"
      accordion="my-accordion"
      role="tabpanel">
      <b-card-body class="qna_content">
        <b-card-text class="p-4">{{ content }}</b-card-text>
        <comment-write :qnaNo="qnaNo"></comment-write>
        <b-list-group class="p-3">
          <comment-row
            v-for="comment in comments"
            :key="comment.commentNo"
            :qnaNo="qnaNo"
            :comment="comment"></comment-row>
        </b-list-group>
      </b-card-body>
      <b-card-footer
        v-if="
          this.userInfo &&
          (userId == this.userInfo.userId || this.userInfo.admin)
        "
        class="p-4 text-center">
        <b-button size="sm" inline-block class="mx-1" @click="moveModifyQnA">
          <b-card-text>수정</b-card-text>
        </b-button>
        <b-button size="sm" inline-block class="mx-1" @click="deleteQnA">
          <b-card-text>삭제</b-card-text>
        </b-button>
      </b-card-footer>
    </b-collapse>
  </b-card>
</template>

<script>
import { mapActions, mapState, mapGetters } from "vuex";
const memberStore = "memberStore";

export default {
  // 부모 component로 부터 전달받은 도서정보
  props: {
    qnaNo: Number,
    title: String,
    userId: String,
    content: String,
    Qna: Object,
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    ...mapGetters(["comments"]),
    searchComment() {
      return this.getComments(this.qnaNo);
    },
  },
  data() {
    return {
      select: "",
    };
  },
  components: {
    "comment-write": () => import("@/components/qna/include/CommentWrite.vue"),
    "comment-row": () => import("@/components/qna/include/CommentRow.vue"),
  },
  methods: {
    ...mapActions(["getQnA", "getComments", "deleteQna", "getQLists"]),
    deleteQnA() {
      this.$fire({
        title: "Confirm",
        text: "QnA를 삭제하시겠습니까?",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes",
      }).then((result) => {
        if (result.value) {
          const payload = {
            qnaNo: this.qnaNo,
            callback: () => {
              this.getQLists();
            },
          };
          this.deleteQna(payload);
        }
      });
    },
    moveModifyQnA() {
      this.getQnA(this.Qna);
      console.log(this.Qna + "here");
      this.$router.push({
        path: "/QnA/modify/" + this.qnaNo,
      });
    },
    toggle() {
      this.getComments(this.qnaNo);
    },
  },
  created() {
    console.log(this.userInfo);
    console.log("qna 번호 출력" + this.qnaNo);
  },
};
</script>

<style scope></style>
