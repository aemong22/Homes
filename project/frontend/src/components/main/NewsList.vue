<template>
  <div class="p-4 m-1 newsList">
    <h5><b>TODAY NEWS</b><span class="subTitle"> 부동산</span></h5>
    <hr />
    <div style="display: flex; justify-content: center; flex-wrap: wrap">
      <land-card-view
        v-for="(news, index) in newsList"
        :key="index"
        :news="news"></land-card-view>
    </div>
  </div>
</template>

<script>
import LandCardView from "@/components/main/LandCardView.vue";
import http from "@/util/http-common";

export default {
  components: { LandCardView },
  data() {
    return {
      newsList: {},
    };
  },
  created() {
    http.get("land/news").then(({ data }) => {
      this.newsList = data.body;
    });
  },
};
</script>

<style scoped>
.newsList {
  background-color: white;
}
.newsList > h5 {
  font-size: 25px;
  color: #8da9c4;
  text-align: center;
}
.subTitle {
  font-size: 15px;
  color: gray;
}
</style>
