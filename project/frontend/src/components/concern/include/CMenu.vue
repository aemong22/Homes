<template>
  <div class="p-4">
    <b-col class="text-center pb-2">
      <h3>관심지역</h3>
    </b-col>
    <b-nav tabs align="center">
      <b-nav-item to="/concern/recent" exact exact-active-class="active"
        >최근 본 지역</b-nav-item
      >
      <b-nav-item to="/concern/list" exact exact-active-class="active"
        >찜한 관심 지역</b-nav-item
      >
    </b-nav>
  </div>
</template>

<script>
export default {};
</script>

<style></style>
