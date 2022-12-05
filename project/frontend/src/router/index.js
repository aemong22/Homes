import Vue from "vue";
import VueRouter from "vue-router";
import store from "@/store";

Vue.use(VueRouter);

const onlyAuthUser = async (to, from, next) => {
  const checkUserInfo = store.getters["memberStore/checkUserInfo"];
  const checkToken = store.getters["memberStore/checkToken"];
  let token = sessionStorage.getItem("access-token");
  console.log("로그인 처리 전", checkUserInfo, token);

  if (checkUserInfo != null && token) {
    console.log("토큰 유효성 체크하러 가자!!!!");
    await store.dispatch("memberStore/getUserInfo", token);
  }
  if (!checkToken || checkUserInfo === null) {
    alert("로그인이 필요한 페이지입니다..");
    // next({ name: "login" });
    console.log(checkToken);
    console.log(checkUserInfo);
    router.push({ name: "HomeView" });
  } else {
    console.log("로그인 했다!!!!!!!!!!!!!.");
    next();
  }
};

// Dynamic module loading을 통해 component를 불러옴
const routes = [
  {
    path: "/",
    name: "HomeView",
    component: () => import("@/views/HomeView.vue"),
  },
  {
    path: "/QnA",
    name: "QnA",
    component: () => import("@/views/QnAView.vue"),
    redirect: "/QnA/list",
    children: [
      {
        path: "list",
        name: "QList",
        component: () => import("@/components/qna/QList.vue"),
      },
      {
        path: "create",
        name: "QCreate",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/qna/QCreate.vue"),
      },
      {
        path: "modify/:isbn",
        name: "QModify",
        component: () => import("@/components/qna/QModify.vue"),
      },
      {
        path: "my",
        name: "QMy",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/qna/QMy.vue"),
      },
    ],
  },
  {
    path: "/user",
    name: "user",
    redirect: "/user/mypage",
    component: () => import("@/views/AppUser"),
    children: [
      {
        path: "mypage",
        name: "mypage",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/user/UserMyPage"),
      },
      {
        path: "edit",
        name: "userEdit",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/user/UserEdit"),
      },
      {
        path: "admin/user",
        name: "adminUser",
        component: () => import("@/components/user/AdminUserList"),
      },
    ],
  },
  {
    path: "/house",
    name: "house",
    component: () => import("@/views/AppHouse"),
    redirect: "/house/housemain",
    children: [
      {
        path: "housemain",
        name: "housemain",
        component: () => import("@/components/house/HouseMain.vue"),
      },
      {
        path: "concernmain",
        name: "ConcernMain",
        beforeEnter: onlyAuthUser,
        component: () => import("@/components/house/concern/ConcernMain.vue"),
      },
    ],
  },
  {
    path: "/concern",
    name: "concern",
    beforeEnter: onlyAuthUser,
    component: () => import("@/views/AppConcern"),
    redirect: "/concern/list",
    children: [
      {
        path: "list",
        name: "CList",
        component: () => import("@/components/concern/CList.vue"),
      },
      {
        path: "recent",
        name: "CRecentList",
        component: () => import("@/components/concern/CRecentList.vue"),
      },
    ],
  },
  {
    path: "/sidebar",
    name: "sidebar",
    component: () => import("@/components/concern/SideBar.vue"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;
