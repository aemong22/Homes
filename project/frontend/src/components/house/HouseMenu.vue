<template>
  <div class="p-4">
    <b-col class="text-center pb-2">
      <h3><b-icon icon="house-fill"></b-icon> House Service</h3>
    </b-col>
    <b-nav tabs align="center">
      <b-nav-item to="/house/housemain" exact exact-active-class="active"
        >매매 정보 검색</b-nav-item
      >
      <b-nav-item to="/house/concernmain" exact exact-active-class="active"
        >찜한 관심 지역</b-nav-item
      >
    </b-nav>
  </div>
</template>

<script>
export default {};
</script>

<style></style>
