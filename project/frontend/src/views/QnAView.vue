<template>
  <div>
    <qna-menu></qna-menu>
    <router-view></router-view>
  </div>
</template>
<script>
export default {
  components: {
    "qna-menu": () => import("@/components/qna/include/QMenu.vue"),
  },
};
</script>

<style scoped>
@import "@/assets/css/qna.css";
</style>
