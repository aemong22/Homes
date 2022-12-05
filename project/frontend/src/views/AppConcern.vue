<template>
  <div>
    <concern-menu></concern-menu>
    <router-view></router-view>
  </div>
</template>
<script>
export default {
  components: {
    "concern-menu": () => import("@/components/concern/include/CMenu.vue"),
  },
};
</script>
