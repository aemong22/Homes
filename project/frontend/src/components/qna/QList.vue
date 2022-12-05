<template>
  <b-container class="bv-example-row mt-3">
    <div>
      <b-jumbotron class="p-4 bg-white border explain">
        <h5>QnA 게시판 이용 안내</h5>
        <p>사이트 이용 문의 및 답변 게시판입니다.</p>
        <b-input-group class="m-0" size="sm">
          <b-form-input
            placeholder="검색어를 입력해주세요."
            @keyup="search"
            v-model="searchValue"></b-form-input>
        </b-input-group>
      </b-jumbotron>
    </div>
    <div>
      <b-row class="qna_table_header mx-0 px-3 py-2 my-1 text-center"
        ><b-col cols="2">번호</b-col>
        <b-col>제목</b-col>
        <b-col cols="3">작성자</b-col></b-row
      >
    </div>
    <div class="accordion">
      <b-accordion v-if="qlists.length">
        <list-row
          v-for="(QnA, index) in qlists"
          :key="index"
          :qnaNo="QnA.qnaNo"
          :title="QnA.subject"
          :userId="QnA.userId"
          :content="QnA.content"
          :Qna="QnA"></list-row>
      </b-accordion>
      <b-col v-else class="text-center">등록된 질문이 없습니다.</b-col>
    </div>
  </b-container>
</template>

<script>
import { mapActions, mapGetters } from "vuex";

export default {
  data() {
    return { searchValue: "" };
  },
  // Dynamic module loading을 통해 component를 불러옴
  components: {
    "list-row": () => import("@/components/qna/include/ListRow.vue"),
  },
  methods: {
    ...mapActions(["getQLists", "getQSearch"]),
    movePage: function () {
      this.$router.push({ name: "QCreate" });
    },
    search: function () {
      if (this.searchValue) {
        this.getQSearch(this.searchValue);
      } else {
        this.getQLists();
      }
    },
  },
  created() {
    // action 호출
    console.log("here");
    this.getQLists();
  },
  computed: {
    ...mapGetters(["qlists"]),
  },
};
</script>

<style scoped>
.explain {
  box-shadow: rgba(0, 0, 0, 0.1) 0px 1px 2px 0px;
}
</style>
