<template>
  <div class="p-4">
    <b-col class="text-center pb-2">
      <h3>QnA</h3>
    </b-col>
    <b-nav tabs align="center">
      <b-nav-item exact-active-class="active" to="/QnA/list"
        ><router-link :to="{ name: 'QList' }">ALL</router-link></b-nav-item
      >
      <b-nav-item exact-active-class="active" to="/QnA/create"
        ><router-link :to="{ name: 'QCreate' }">CREATE</router-link></b-nav-item
      >
      <b-nav-item exact-active-class="active" to="/QnA/my"
        ><router-link :to="{ name: 'QMy' }">My</router-link></b-nav-item
      >
    </b-nav>
  </div>
</template>

<script>
export default {};
</script>

<style></style>
