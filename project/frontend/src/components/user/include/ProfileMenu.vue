<template>
  <div>
    <b-row class="pt-5 pb-3" align-h="center">
      <div class="profile-title">프로필</div>
    </b-row>
    <b-row class="mb-4">
      <div style="margin: 0 auto" class="border rounded px-3">
        <b-row>
          <b-col sm="3" class="pt-4" style="min-width: 250px">
            <div
              class="card-body profile-card pt-0 d-flex flex-column align-items-center">
              <img
                src="@/assets/img/profile.png"
                alt="Profile"
                class="rounded-circle border mb-3 p-1"
                style="max-width: 120px" />
              <h5>{{ userInfo.userName }}</h5>
            </div>
          </b-col>
        </b-row>
        <hr />
        <b-row class="mx-1">
          <b-col>
            <div class="sub-info">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24">
                <path
                  d="M3 13h1v7c0 1.103.897 2 2 2h12c1.103 0 2-.897 2-2v-7h1a1 1 0 0 0 .707-1.707l-9-9a.999.999 0 0 0-1.414 0l-9 9A1 1 0 0 0 3 13zm7 7v-5h4v5h-4zm2-15.586 6 6V15l.001 5H16v-5c0-1.103-.897-2-2-2h-4c-1.103 0-2 .897-2 2v5H6v-9.586l6-6z"></path>
              </svg>
            </div>
            <div class="sub-info">관심 지역</div>
            <div class="number" type="button" @click="moveConcern">
              {{ this.countC }}
            </div>
          </b-col>
          <b-col
            ><div class="sub-info">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24">
                <path
                  d="M20 2H4c-1.103 0-2 .897-2 2v12c0 1.103.897 2 2 2h3v3.767L13.277 18H20c1.103 0 2-.897 2-2V4c0-1.103-.897-2-2-2zm0 14h-7.277L9 18.233V16H4V4h16v12z"></path>
                <path d="M7 7h10v2H7zm0 4h7v2H7z"></path>
              </svg>
            </div>
            <div class="sub-info">문의 개수</div>
            <div class="number" type="button" @click="moveMyQna">
              {{ this.countQ }}
            </div></b-col
          >
        </b-row>
      </div>
    </b-row>
    <b-row align-h="center">
      <b-col
        class="menu p-1 border col-sm-4 col-md-2"
        :class="{ selectMenu: select == 'mypage' }"
        type="button"
        @click="moveMyProfile">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24">
          <path
            d="M15 11h7v2h-7zm1 4h6v2h-6zm-2-8h8v2h-8zM4 19h10v-1c0-2.757-2.243-5-5-5H7c-2.757 0-5 2.243-5 5v1h2zm4-7c1.995 0 3.5-1.505 3.5-3.5S9.995 5 8 5 4.5 6.505 4.5 8.5 6.005 12 8 12z"></path>
        </svg>
        <div class="mypage">상세정보</div>
      </b-col>
      <b-col
        class="menu p-1 border col-sm-4 col-md-2"
        :class="{ selectMenu: select == 'userEdit' }"
        @click="moveMyProfileEdit"
        type="button"
        ><svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24">
          <path
            d="m16 2.012 3 3L16.713 7.3l-3-3zM4 14v3h3l8.299-8.287-3-3zm0 6h16v2H4z"></path>
        </svg>
        <div class="meun-title">프로필 수정</div></b-col
      >
      <b-col
        v-if="userInfo.admin"
        class="menu p-1 border col-sm-4 col-md-2"
        :class="{ selectMenu: select == 'adminUser' }"
        type="button"
        @click="moveAdmin">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24">
          <circle cx="12" cy="6" r="2"></circle>
          <path
            d="M14 9h-4a1 1 0 0 0-.8.4l-3 4 1.6 1.2L9 13v7h2v-4h2v4h2v-7l1.2 1.6 1.6-1.2-3-4A1 1 0 0 0 14 9z"></path>
        </svg>
        <div class="meun-title">회원관리</div>
      </b-col>
      <b-col
        v-else
        class="menu p-1 border col-sm-4 col-md-2"
        type="button"
        @click="onDeleteUser">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24">
          <path
            d="M8.586 18 12 21.414 15.414 18H19c1.103 0 2-.897 2-2V4c0-1.103-.897-2-2-2H5c-1.103 0-2 .897-2 2v12c0 1.103.897 2 2 2h3.586zM5 4h14v12h-4.414L12 18.586 9.414 16H5V4z"></path>
          <path
            d="M9.707 13.707 12 11.414l2.293 2.293 1.414-1.414L13.414 10l2.293-2.293-1.414-1.414L12 8.586 9.707 6.293 8.293 7.707 10.586 10l-2.293 2.293z"></path>
        </svg>
        <div class="meun-title">회원탈퇴</div>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";

const memberStore = "memberStore";
export default {
  data() {
    return {
      select: this.$route.name,
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo", "isLogin", "countQ", "countC"]),
  },
  methods: {
    ...mapActions(memberStore, ["deleteUser", "getCountC", "getCountQ"]),
    onDeleteUser() {
      this.$fire({
        title: "Confirm",
        text: this.userInfo.userId + " 정보를 삭제하시겠습니까?",
        type: "warning",
        showCancelButton: true,
        confirmButtonText: "Yes",
      }).then((result) => {
        if (result.value) {
          console.log(this.userInfo.userId + "삭제할 사람");
          this.deleteUser(this.userInfo.userId);
          sessionStorage.removeItem("access-token"); //저장된 토큰 없애기
          sessionStorage.removeItem("refresh-token"); //저장된 토큰 없애기
          if (this.$route.path != "/") this.$router.push({ name: "HomeView" });
        }
      });
    },
    moveMyProfile() {
      this.$router.push({ name: "mypage" });
    },
    moveMyProfileEdit() {
      this.$router.push({ name: "userEdit" });
    },
    moveAdmin() {
      this.$router.push({ name: "adminUser" });
    },
    moveMyQna() {
      this.$router.push({ name: "QMy" });
    },
    moveConcern() {
      this.$router.push({ name: "CList" });
    },
  },
  created() {
    if (!this.isLogin) {
      this.$router.push({ name: "HomeView" });
    }
    this.select = this.$route.name;
    this.getCountC(this.userInfo.userId);
    this.getCountQ(this.userInfo.userId);
  },
  watch: {
    $route() {
      this.select = this.$route.name;
    },
  },
};
</script>

<style>
@import url("@/assets/css/profile.css");
</style>
