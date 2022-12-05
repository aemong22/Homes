<template>
  <div>
    <!-- 로드뷰를 표시할 div 입니다 -->
    <div style="display: none">{{ house }}</div>
    <div id="roadview" style="width: 100%; height: 350px"></div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
const houseStore = "houseStore";
export default {
  name: "HouseRoadview",
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initRoadview();
    } else {
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initRoadview);
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=a0d6bdea2eb0735ecc0dff0c3a7e4add&libraries=services";
      document.head.appendChild(script);
      this.initRoadview();
    }
  },
  computed: {
    ...mapGetters(houseStore, ["house", "sido", "gugun"]),
  },
  updated() {
    this.newhouse(this.house);
  },
  methods: {
    newhouse(house) {
      if (house) {
        this.initRoadview();
      }
    },
    initRoadview() {
      const roadviewContainer = document.getElementById("roadview"); //로드뷰를 표시할 div
      this.roadview = new kakao.maps.Roadview(roadviewContainer); //로드뷰 객체
      const roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
      this.roadviewClient = roadviewClient;

      var roadview = this.roadview;

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();

      var thiz = this;

      var dong = this.house["법정동"] ? this.house["법정동"] : this.house.dong;
      var jibeon = this.house["지번"] ? this.house["지번"] : this.house.jibun;

      var juso = this.sido + " " + this.gugun + " " + dong + " " + jibeon;

      var position = new kakao.maps.LatLng(33.450701, 126.570667);

      // 주소로 좌표를 검색합니다
      geocoder.addressSearch(juso, function (result, status) {
        // 정상적으로 검색이 완료됐으면
        if (status === kakao.maps.services.Status.OK) {
          position = new kakao.maps.LatLng(result[0].y, result[0].x);

          // 특정 위치의 좌표와 가까운 로드뷰의 panoId를 추출하여 로드뷰를 띄운다.
          roadviewClient.getNearestPanoId(position, 50, function (panoId) {
            roadview.setPanoId(panoId, position); //panoId와 중심좌표를 통해 로드뷰 실행
          });

          var housename = thiz.house["연립다세대"]
            ? thiz.house["연립다세대"]
            : thiz.house.apartmentName;

          // 커스텀 오버레이에 표시할 내용입니다
          // HTML 문자열 또는 Dom Element 입니다
          const content = `
            <div class="overlay_info">
              <a href="https://map.kakao.com/link/map/${housename},${result[0].y},${result[0].x}" target="_blank"><strong>${housename}</strong></a>
              <div class="desc">
                <span class="address">${juso}</span>
              </div>
            </div>`;

          kakao.maps.event.addListener(roadview, "init", function () {
            // 커스텀 오버레이를 생성합니다
            var rvCustomOverlay = new kakao.maps.CustomOverlay({
              position: position,
              content: content,
              xAnchor: 0.5, // 커스텀 오버레이의 x축 위치입니다. 1에 가까울수록 왼쪽에 위치합니다. 기본값은 0.5 입니다
              yAnchor: 0.5, // 커스텀 오버레이의 y축 위치입니다. 1에 가까울수록 위쪽에 위치합니다. 기본값은 0.5 입니다
            });

            //rvCustomOverlay.setAltitude(2); //커스텀 오버레이의 고도값을 설정합니다.(로드뷰 화면 중앙이 0입니다)
            rvCustomOverlay.setMap(roadview);

            var projection = roadview.getProjection(); // viewpoint(화면좌표)값을 추출할 수 있는 projection 객체를 가져옵니다.

            // 커스텀오버레이의 position과 altitude값을 통해 viewpoint값(화면좌표)를 추출합니다.
            var viewpoint = projection.viewpointFromCoords(
              rvCustomOverlay.getPosition(),
              rvCustomOverlay.getAltitude(),
            );

            roadview.setViewpoint(viewpoint); //커스텀 오버레이를 로드뷰의 가운데에 오도록 로드뷰의 시점을 변화 시킵니다.
          });
        }
      });
    },
  },
};
</script>

<style>
.overlay_info {
  border-radius: 6px;
  margin-bottom: 12px;
  float: left;
  position: relative;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  background-color: #fff;
}
.overlay_info:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}
.overlay_info a {
  display: block;
  background: #134074;
  background: #134074
    url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
    no-repeat right 14px center;
  text-decoration: none;
  color: #fff;
  padding: 12px 36px 12px 14px;
  font-size: 14px;
  border-radius: 6px 6px 0 0;
}
.overlay_info a strong {
  background: url(../../assets/img/mapicon/home2.png) no-repeat;
  padding-left: 27px;
  background-size: 20px 17px;
}
.overlay_info .desc {
  padding: 14px;
  position: relative;
  min-width: 190px;
  height: 56px;
}
.overlay_info .address {
  font-size: 12px;
  color: #333;
  position: absolute;
  left: 14px;
  right: 14px;
  top: 24px;
  white-space: normal;
}
.overlay_info:after {
  content: "";
  position: relative;
  margin-left: -11px;
  left: 50%;
  bottom: -12px;
  width: 22px;
  height: 12px;
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png)
    no-repeat 0 bottom;
}
</style>
