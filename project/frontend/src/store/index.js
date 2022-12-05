import Vue from "vue";
import Vuex from "vuex";
import http from "@/util/http-common";
import persistedState from "vuex-persistedstate";
import memberStore from "@/store/modules/memberStore";
import houseStore from "@/store/modules/houseStore";
import moment from "moment";

Vue.use(Vuex);

function alertMessage(statusCode) {
  switch (statusCode) {
    case 400:
      alert("잘못된 요청입니다.");
      break;

    case 500:
      alert("서버 오류!!!");
      break;
  }
}

export default new Vuex.Store({
  modules: {
    memberStore,
    houseStore,
  },

  state: {
    qlists: [],
    qna: {},
    comments: [],
  },
  getters: {
    qlists(state) {
      return state.qlists;
    },
    qna(state) {
      return state.qna;
    },
    comments(state) {
      return state.comments;
    },
  },
  mutations: {
    QLists(state, payload) {
      // 데이터 재가공 (가격순으로 번호순 정렬)
      payload.qlists.sort((a, b) => {
        return b.qnaNo - a.qnaNo;
      });
      // state에 가공된 데이터 저장
      state.qlists = payload.qlists;
    },
    QnA(state, payload) {
      state.qna = payload.qna;
    },
    COMMENTS(state, payload) {
      console.log(payload);
      payload.comments.map((comment) => {
        const obj = moment(comment.commentTime, "YYYY-MM-DD hh:mm:ss"); // 변경 전 양식으로 Moment 객체 생성
        comment.commentTime = obj.format("MM-DD HH:mm"); // 원하는 형식으로 변경 후 commentTime 갱신
        return comment;
      });
      state.comments = payload.comments;
    },
  },
  actions: {
    deleteComment(context, payload) {
      http.delete(`/comment/${payload.commentNo}`).then((response) => {
        switch (response.status) {
          case 200:
            payload.callback();
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    modifyComment(context, payload) {
      http
        .put(`/comment/${payload.comment.commentNo}`, payload.comment)
        .then((response) => {
          switch (response.status) {
            case 200:
              payload.callback();
              break;

            case 400:
            case 500:
              alertMessage(response.status);
              break;
          }
        });
    },
    getComments(context, isbn) {
      http.get(`/comment/${isbn}`).then((response) => {
        switch (response.status) {
          case 200:
            console.log("댓글 data" + response.data);
            context.commit({
              type: "COMMENTS",
              comments: response.data,
            });
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    createComment(context, payload) {
      console.log(payload.comment);
      http.post("/comment", payload.comment).then((response) => {
        switch (response.status) {
          case 200:
            payload.callback();
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    // context 객체는 store 객체이다.
    getQLists(context) {
      http.get("/qna/list").then((response) => {
        switch (response.status) {
          case 200:
            console.log(response.data);
            context.commit({ type: "QLists", qlists: response.data });
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    getQSearch(context, payload) {
      console.log(payload);
      http.get(`/qna/search/${payload}`).then((response) => {
        switch (response.status) {
          case 200:
            context.commit({ type: "QLists", qlists: response.data });
            console.log("search" + response.data);
            break;
          case 204:
            context.commit({ type: "QLists", qlists: [] });
            break;
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    createQna(context, payload) {
      http.post("/qna/write", payload.qna).then((response) => {
        switch (response.status) {
          case 200:
            alert("등록 되었습니다.");
            //this.moveList();
            payload.callback();
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    modifyQna(context, payload) {
      http.put(`/qna/modify`, payload.qna).then((response) => {
        switch (response.status) {
          case 200:
            alert("수정이 완료되었습니다.");
            payload.callback();
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
    getQnA(context, obj) {
      context.commit({
        type: "QnA",
        qna: obj,
      });
    },
    deleteQna(context, payload) {
      http.delete(`/qna/delete/${payload.qnaNo}`).then((response) => {
        switch (response.status) {
          case 200:
            alert("삭제가 완료되었습니다.");
            //this.$router.push({ name: "BookList" });
            payload.callback();
            break;

          case 400:
          case 500:
            alertMessage(response.status);
            break;
        }
      });
    },
  },
  plugins: [
    persistedState({
      // 기본값 localStorage
      storage: sessionStorage,
    }),
  ],
});
