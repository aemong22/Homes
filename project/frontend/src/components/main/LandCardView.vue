<template>
  <b-card
    :title="news.title"
    :img-src="news.imgUrl"
    img-alt="Image"
    style="width: 240px"
    class="m-3"
    @click="movePage"
    type="button">
    <b-card-text> {{ this.check }} ...</b-card-text>
  </b-card>
</template>

<script>
export default {
  props: {
    news: Object,
  },
  computed: {
    check() {
      return this.news.preview.substring(0, 35);
    },
  },
  methods: {
    movePage() {
      window.open(this.news.newsUrl);
    },
  },
};
</script>

<style scoped>
.slideContent {
  padding: 20px;
  height: 200px;
}
</style>
