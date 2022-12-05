<template>
  <b-container>
    <profile-menu></profile-menu>
    <b-row>
      <b-col>
        <router-view></router-view>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import ProfileMenu from "@/components/user/include/ProfileMenu.vue";

export default {
  name: "AppUser",
  components: {
    ProfileMenu,
  },
};
</script>

<style></style>
