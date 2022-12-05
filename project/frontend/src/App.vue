<template>
  <div id="app">
    <header-nav />
    <!-- <vue-confirm-dialog></vue-confirm-dialog> -->
    <router-view style="margin-top: 100px" />
  </div>
</template>

<script>
import HeaderNav from "@/components/common/HeaderNav.vue";

export default {
  components: {
    HeaderNav,
  },
};
</script>

<style>
.underline {
  display: inline-block;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0) 70%, cyan 30%);
}
@import "@/assets/css/style.css";
</style>
