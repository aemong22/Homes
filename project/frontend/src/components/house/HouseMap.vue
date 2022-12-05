<template>
  <div class="card" style="width: 100%; height: 850px">
    <div class="card-body">
      <!-- <h5 class="card-title">
        <b>실거래가 조회</b> <span>| 업데이트 2022-09-07</span>
      </h5> -->

      <!-- Kakao Map start -->
      <div id="map" style="width: 100%; height: 100%"></div>

      <!-- Kakao Map end -->
    </div>
    <b-container style="display: none">
      <div>{{ sido }} {{ houses }}</div>
      <div>{{ categorys }}</div>
      <div>{{ concernlatlng }}</div>
    </b-container>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from "vuex";
import imgbank from "@/assets/img/mapicon/bank.png";
import imgshop from "@/assets/img/mapicon/shop.png";
import imgfuel from "@/assets/img/mapicon/fuel-station.png";
import imgrestaurant from "@/assets/img/mapicon/restaurant.png";
const houseStore = "houseStore";

export default {
  name: "HouseMap",
  data() {
    return {
      markers: [], //지도에 표시된 마커 객체를 가지고 있을 배열입니다
      bounds: [],
      markers2: [],
    };
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=a0d6bdea2eb0735ecc0dff0c3a7e4add&libraries=services";
      document.head.appendChild(script);
    }
  },
  computed: {
    ...mapGetters(houseStore, [
      "houses",
      "sido",
      "gugun",
      "searchType",
      "categorys",
      "concernlatlng",
    ]),
    housename() {
      if (this.searchType == "APT") {
        return "apartmentName";
      } else {
        return "연립다세대";
      }
    },
  },
  updated() {
    this.map_marker(this.houses);
    this.map_marker2(this.categorys);
    this.changesetmap(this.concernlatlng);
  },
  methods: {
    ...mapActions(houseStore, ["getHouseOneList", "setMapLatLng"]),
    ...mapMutations(houseStore, [
      "CLEAR_CATEGORY_LIST",
      "CLEAR_CATEGORYSRESULT_LIST",
    ]),
    ...mapGetters(houseStore, ["categorysresult"]),
    changesetmap() {
      let thiz = this;

      if (thiz.concernlatlng.lat == "" || thiz.concernlatlng.lng == "") return;
      var coords = new kakao.maps.LatLng(
        this.concernlatlng.lat,
        this.concernlatlng.lng,
      );
      this.map.setCenter(coords);
      return coords;
    },
    getsrcimg(code) {
      let answer = "";
      switch (code) {
        case "MT1":
          answer = "https://cdn-icons-png.flaticon.com/128/5695/5695140.png";
          break;
        case "CS2":
          answer = imgshop;
          break;
        case "PS3":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695239.png";
          break;
        case "SC4":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695214.png";
          break;
        case "AC5":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695224.png";
          break;
        case "PK6":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695094.png";
          break;
        case "OL7":
          answer = imgfuel;
          break;
        case "SW8":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695648.png";
          break;
        case "BK9":
          answer = imgbank;
          break;
        case "AT4":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695658.png";
          break;
        case "FD6":
          answer = imgrestaurant;
          break;
        case "CE7":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695099.png";
          break;
        case "HP8":
          answer = "https://cdn-icons-png.flaticon.com/512/5695/5695628.png";
          break;
        default:
          answer = imgbank;
          break;
      }
      return answer;
    },
    initMap() {
      this.markers = [];
      this.markers2 = [];
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };

      //지도 객체를 등록합니다.
      //지도 객체는 반응형 관리 대상이 아니므로 initMap에서 선언합니다.
      this.map = new kakao.maps.Map(container, options);

      var map = this.map;
      let thiz = this;

      // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다.
      var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      // 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
      kakao.maps.event.addListener(map, "center_changed", function () {
        // 지도의  레벨을 얻어옵니다
        // var level = map.getLevel();

        // 지도의 중심좌표를 얻어옵니다
        var latlng = map.getCenter();

        const payload = {
          lat: latlng.getLat(),
          lng: latlng.getLng(),
        };
        thiz.setMapLatLng(payload);

        // thiz.CLEAR_CATEGORYSRESULT_LIST();
      });

      // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
      thiz.placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 });
      thiz.contentNode = document.createElement("div"); // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다

      // 커스텀 오버레이 컨텐츠를 설정합니다
      thiz.placeOverlay.setContent(thiz.contentNode);

      // 커스텀 오버레이를 숨깁니다
      thiz.placeOverlay.setMap(null);
    },

    //배열에 추가된 마커들을 지도에 표시하거나 삭제하는 함수입니다
    setMarkers(map, marks) {
      for (var i = 0; i < marks.length; i++) {
        marks[i].setMap(map);
      }
      marks = [];
    },
    // "마커 보이기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에 표시하는 함수입니다
    showMarkers(markers) {
      this.setMarkers(this.map, markers);
    },
    // "마커 감추기" 버튼을 클릭하면 호출되어 배열에 추가된 마커를 지도에서 삭제하는 함수입니다
    hideMarkers(markers) {
      this.setMarkers(null, markers);
    },
    setBounds() {
      // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다kers
      // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
      this.map.setBounds(this.bounds);
    },

    map_marker(data) {
      let thiz = this;
      // 마커 표시전 이전 마커 지도에서 삭제
      this.hideMarkers(this.markers);

      // 지도를 재설정할 범위정보 초기화
      thiz.bounds = new kakao.maps.LatLngBounds();

      if (this.sido == null || this.gugun == null) {
        return;
      }

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();

      let apts = data;

      var si = thiz.sido;
      var gu = thiz.gugun;

      apts.forEach((apt) => {
        var dong = apt["법정동"];
        var jibeon = apt["지번"];

        if (thiz.searchType == "APT") {
          dong = apt.dong;
          jibeon = apt.jibun;
        }

        var juso = si + " " + gu + " " + dong + " " + jibeon;

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(juso, function (result, status) {
          // 정상적으로 검색이 완료됐으면
          if (status === kakao.maps.services.Status.OK) {
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
              map: thiz.map,
              position: coords,
            });
            marker.setMap(thiz.map);

            // 생성된 마커를 배열에 추가합니다
            thiz.markers.push(marker);

            // LatLngBounds 객체에 좌표를 추가합니다
            thiz.bounds.extend(coords);

            var iwContent =
              '<div style="text-align:center; padding:5px;">' +
              apt[thiz.housename] +
              "</div>";

            // // 인포윈도우로 장소에 대한 설명을 표시합니다
            var infowindow = new kakao.maps.InfoWindow({
              content: iwContent,
            });

            // 마커에 마우스오버 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, "mouseover", function () {
              // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
              infowindow.open(thiz.map, marker);
            });

            // 마커에 마우스아웃 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, "mouseout", function () {
              // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
              infowindow.close();
            });

            // 마커에 클릭 이벤트를 등록합니다
            kakao.maps.event.addListener(marker, "click", function () {
              thiz.find_apt(apts, apt[thiz.housename]);
              thiz.map.panTo(coords);
            });

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            //map.setCenter(coords);
          }
          // 지도 범위 재설정
          thiz.setBounds();
        });
      });
    },
    find_apt(apts, apt_name) {
      let thiz = this;
      var search = [];
      //일치하는 아파트 목록 찾기
      apts.forEach((apt) => {
        var name = apt[thiz.housename];
        if (name == apt_name) {
          search.push(apt);
        }
      });

      //해당 아파트에 대해서만 표시하기
      // this.makeList(search);
      this.getHouseOneList(search);
    },
    // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
    displayPlaceInfo(place) {
      let thiz = this;
      var content =
        '<div class="placeinfo">' +
        '   <a class="title" href="' +
        place.place_url +
        '" target="_blank" title="' +
        place.place_name +
        '">' +
        place.place_name +
        "</a>";

      if (place.road_address_name) {
        content +=
          '    <span title="' +
          place.road_address_name +
          '">' +
          place.road_address_name +
          "</span>" +
          '  <span class="jibun" title="' +
          place.address_name +
          '">(지번 : ' +
          place.address_name +
          ")</span>";
      } else {
        content +=
          '    <span title="' +
          place.address_name +
          '">' +
          place.address_name +
          "</span>";
      }

      content +=
        '    <span class="tel">' +
        place.phone +
        "</span>" +
        "</div>" +
        '<div class="after"></div>';

      thiz.contentNode.innerHTML = content;
      thiz.placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
      thiz.placeOverlay.setMap(thiz.map);
    },
    map_marker2(datas) {
      let thiz = this;
      let A = this.categorysresult();
      thiz.bounds = new kakao.maps.LatLngBounds();
      // console.log("marker2", datas);

      // 커스텀 오버레이를 숨깁니다
      thiz.placeOverlay.setMap(null);

      thiz.hideMarkers(thiz.markers2);

      datas.forEach((data) => {
        let apts = A[data];

        var imageSrc = thiz.getsrcimg(data), //"./assets/img/mapicon/bank.png",
          //"https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png", // 마커이미지의 주소입니다
          imageSize = new kakao.maps.Size(42, 46), // 마커이미지의 크기입니다
          imageOption = { offset: new kakao.maps.Point(21, 46) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

        // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
        var markerImage = new kakao.maps.MarkerImage(
          imageSrc,
          imageSize,
          imageOption,
        );
        apts.forEach((apt) => {
          var coords = new kakao.maps.LatLng(apt.y, apt.x);

          // 결과값으로 받은 위치를 마커로 표시합니다
          var marker = new kakao.maps.Marker({
            map: thiz.map,
            position: coords,
            image: markerImage, // 마커이미지 설정
          });
          marker.setMap(thiz.map);

          // 생성된 마커를 배열에 추가합니다
          thiz.markers2.push(marker);

          // LatLngBounds 객체에 좌표를 추가합니다
          thiz.bounds.extend(coords);

          // 마커에 클릭 이벤트를 등록합니다
          kakao.maps.event.addListener(marker, "click", function () {
            thiz.map.panTo(coords);
            thiz.displayPlaceInfo(apt);
          });

          // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
          //map.setCenter(coords);
          // 지도 범위 재설정
          thiz.setBounds();
        });
      });
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
#map {
  width: 400px;
  height: 400px;
}

.button-group {
  margin: 10px 0px;
}

button {
  margin: 0 3px;
}

.map_wrap,
.map_wrap * {
  margin: 0;
  padding: 0;
  font-family: "Malgun Gothic", dotum, "돋움", sans-serif;
  font-size: 12px;
}
.map_wrap {
  position: relative;
  width: 100%;
  height: 350px;
}
#category {
  position: absolute;
  top: 10px;
  left: 10px;
  border-radius: 5px;
  border: 1px solid #909090;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
  background: #fff;
  overflow: hidden;
  z-index: 2;
}
#category li {
  float: left;
  list-style: none;
  width: 50px;
  border-right: 1px solid #acacac;
  padding: 6px 0;
  text-align: center;
  cursor: pointer;
}
#category li.on {
  background: #eee;
}
#category li:hover {
  background: #ffe6e6;
  border-left: 1px solid #acacac;
  margin-left: -1px;
}
#category li:last-child {
  margin-right: 0;
  border-right: 0;
}
#category li span {
  display: block;
  margin: 0 auto 3px;
  width: 27px;
  height: 28px;
}
#category li .category_bg {
  background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png)
    no-repeat;
}
#category li .bank {
  background-position: -10px 0;
}
#category li .mart {
  background-position: -10px -36px;
}
#category li .pharmacy {
  background-position: -10px -72px;
}
#category li .oil {
  background-position: -10px -108px;
}
#category li .cafe {
  background-position: -10px -144px;
}
#category li .store {
  background-position: -10px -180px;
}
#category li.on .category_bg {
  background-position-x: -46px;
}
.placeinfo_wrap {
  position: absolute;
  bottom: 28px;
  left: -150px;
  width: 300px;
}
.placeinfo {
  position: relative;
  width: 100%;
  border-radius: 6px;
  border: 1px solid #ccc;
  border-bottom: 2px solid #ddd;
  padding-bottom: 10px;
  background: #fff;
}
.placeinfo:nth-of-type(n) {
  border: 0;
  box-shadow: 0px 1px 2px #888;
}
.placeinfo_wrap .after {
  content: "";
  position: relative;
  margin-left: -12px;
  left: 50%;
  width: 22px;
  height: 12px;
  background: url("https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png");
}
.placeinfo a,
.placeinfo a:hover,
.placeinfo a:active {
  color: #fff;
  text-decoration: none;
}
.placeinfo a,
.placeinfo span {
  display: block;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}
.placeinfo span {
  margin: 5px 5px 0 5px;
  cursor: default;
  font-size: 13px;
}
.placeinfo .title {
  font-weight: bold;
  font-size: 14px;
  border-radius: 6px 6px 0 0;
  margin: -1px -1px 0 -1px;
  padding: 10px;
  color: #fff;
  background: #134074;
  background: #134074
    url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
    no-repeat right 14px center;
}
.placeinfo .tel {
  color: #0f7833;
}
.placeinfo .jibun {
  color: #999;
  font-size: 11px;
  margin-top: 0;
}
</style>
