<template>
  <div>
    <house-menu></house-menu>
    <router-view></router-view>
  </div>
</template>
<script>
export default {
  name: "AppHouse",
  components: {
    "house-menu": () => import("@/components/house/HouseMenu.vue"),
  },
};
</script>
<style></style>
