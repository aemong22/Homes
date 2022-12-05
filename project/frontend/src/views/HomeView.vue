<template>
  <div>
    <b-container fluid class="text-center" id="mainbg">
      <div class="border-bottom">어떤 집을 찾으세요?</div>
      <div class="subtitle">원하는 정보를 한눈에</div>
    </b-container>
    <b-container fluid style="background-color: #edeff6">
      <b-container class="p-4" style="height: 400px">
        <div class="Title">구해줘 홈즈</div>
        <div class="subTitle">
          구해줘홈즈는 부동산 정보를 알려주는 사이트입니다.
        </div>
        <b-row align-h="center">
          <b-col cols="3" class="servicecontent p-3 m-2">
            <div class="serviceImg">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="48"
                height="48"
                viewBox="0 0 24 24"
                style="fill: rgba(0, 0, 0, 1); transform: ; msfilter: ">
                <path
                  d="M3 13h1v7c0 1.103.897 2 2 2h12c1.103 0 2-.897 2-2v-7h1a1 1 0 0 0 .707-1.707l-9-9a.999.999 0 0 0-1.414 0l-9 9A1 1 0 0 0 3 13zm7 7v-5h4v5h-4zm2-15.586 6 6V15l.001 5H16v-5c0-1.103-.897-2-2-2h-4c-1.103 0-2 .897-2 2v5H6v-9.586l6-6z"></path>
              </svg>
            </div>
            <div class="subServiceTitle">매매 정보</div>
            <br />
            복잡한 과정없이 1분이면 조회 완료!<br />
            원하는 지역과 날짜를 선택하여 매매정보를 얻으세요.<br />
            관심지역에 넣으면 더 빠르게 조회가능해요!
          </b-col>
          <b-col cols="3" class="servicecontent p-3 m-2">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="48"
              height="48"
              viewBox="0 0 24 24"
              style="fill: rgba(0, 0, 0, 1); transform: ; msfilter: ">
              <path
                d="M19.148 2.971A2.008 2.008 0 0 0 17.434 2H6.566c-.698 0-1.355.372-1.714.971L2.143 7.485A.995.995 0 0 0 2 8a3.97 3.97 0 0 0 1 2.618V19c0 1.103.897 2 2 2h14c1.103 0 2-.897 2-2v-8.382A3.97 3.97 0 0 0 22 8a.995.995 0 0 0-.143-.515l-2.709-4.514zm.836 5.28A2.003 2.003 0 0 1 18 10c-1.103 0-2-.897-2-2 0-.068-.025-.128-.039-.192l.02-.004L15.22 4h2.214l2.55 4.251zM10.819 4h2.361l.813 4.065C13.958 9.137 13.08 10 12 10s-1.958-.863-1.993-1.935L10.819 4zM6.566 4H8.78l-.76 3.804.02.004C8.025 7.872 8 7.932 8 8c0 1.103-.897 2-2 2a2.003 2.003 0 0 1-1.984-1.749L6.566 4zM10 19v-3h4v3h-4zm6 0v-3c0-1.103-.897-2-2-2h-4c-1.103 0-2 .897-2 2v3H5v-7.142c.321.083.652.142 1 .142a3.99 3.99 0 0 0 3-1.357c.733.832 1.807 1.357 3 1.357s2.267-.525 3-1.357A3.99 3.99 0 0 0 18 12c.348 0 .679-.059 1-.142V19h-3z"></path>
            </svg>
            <div class="subServiceTitle">주변 정보</div>
            <br />
            주변정보 탐색이 가능해요!<br />
            대형마트, 편의점, 어린이 집 등 알고 싶은 주변환경을 검색해보세요!
          </b-col>
          <b-col cols="3" class="servicecontent p-3 m-2">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="48"
              height="48"
              viewBox="0 0 24 24"
              style="fill: rgba(0, 0, 0, 1); transform: ; msfilter: ">
              <path
                d="M19.875 3H4.125C2.953 3 2 3.897 2 5v14c0 1.103.953 2 2.125 2h15.75C21.047 21 22 20.103 22 19V5c0-1.103-.953-2-2.125-2zm0 16H4.125c-.057 0-.096-.016-.113-.016-.007 0-.011.002-.012.008L3.988 5.046c.007-.01.052-.046.137-.046h15.75c.079.001.122.028.125.008l.012 13.946c-.007.01-.052.046-.137.046z"></path>
              <path
                d="M6 7h6v6H6zm7 8H6v2h12v-2h-4zm1-4h4v2h-4zm0-4h4v2h-4z"></path>
            </svg>
            <div class="subServiceTitle">부동산 뉴스</div>
            <br />
            매일 부동산에 관련된 뉴스를 보여줘요!<br />
            뉴스를 통해 부동산 시장 동향및 전망을 알아보세요!
          </b-col>
        </b-row>
      </b-container>
    </b-container>
    <b-container class="mb-4">
      <b-container>
        <news-list />
        <b-row align-h="center">
          <b-col
            cols="2"
            type="button"
            class="moreButton border rounded py-1 px-3"
            @click="moveNewsPage"
            >더 알아보기</b-col
          >
        </b-row>
      </b-container>
    </b-container>
  </div>
</template>
<script>
import NewsList from "@/components/main/NewsList.vue";

export default {
  components: { NewsList },
  methods: {
    moveNewsPage() {
      window.open("https://land.naver.com/news/");
    },
  },
};
</script>
<style scoped>
@import "@/assets/css/home.css";
</style>
