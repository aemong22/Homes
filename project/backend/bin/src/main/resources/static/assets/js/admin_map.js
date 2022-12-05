var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 5, // 지도의 확대 레벨
  };

// 지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

function map_marker(data) {
  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  let apts = data;

  let sisel = document.querySelector("#sido");
  let gusel = document.querySelector("#gugun");
  var si = sisel[sisel.selectedIndex].innerText;
  var gu = gusel[gusel.selectedIndex].innerText;

  apts.forEach((apt) => {
	
    var dong = apt.dong;
    var jibeon = apt.jibun;

    var juso = si + " " + gu + " " + dong + " " + jibeon;
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(juso, function (result, status) {
      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
          map: map,
          position: coords,
        });
        marker.setMap(map);

        var iwContent =
          '<div style="text-align:center; padding:5px;">' +
          apt.apartmentName +
          "</div>";

        // // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
          content: iwContent,
        });

        // 마커에 마우스오버 이벤트를 등록합니다
        kakao.maps.event.addListener(marker, "mouseover", function () {
          // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
          infowindow.open(map, marker);
        });

        // 마커에 마우스아웃 이벤트를 등록합니다
        kakao.maps.event.addListener(marker, "mouseout", function () {
          // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
          infowindow.close();
        });

        // 마커에 클릭 이벤트를 등록합니다
        kakao.maps.event.addListener(marker, "click", function () {
          console.log("click!");
          find_apt(apts, apt.apartmentName);
        });

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
      }
    });
  });
}

function find_apt(apts, apt_name) {
  var search = [];
  //일치하는 아파트 목록 찾기
  apts.forEach((apt) => {
    var name = apt.apartmentName;
    if (name == apt_name) {
      search.push(apt);
    }
  });

  //해당 아파트에 대해서만 표시하기
  makeList(search);
}

function makeList(data) {
  document.querySelector("table").setAttribute("style", "display: ;");
  let tbody = document.querySelector("#aptlist");

  let apts = data;
  //console.log(apts);
  initTable();

  apts.forEach((apt) => {
    let tr = document.createElement("tr");

    let nameTd = document.createElement("td");
    nameTd.appendChild(document.createTextNode(apt.apartmentName));
    tr.appendChild(nameTd);

    let floorTd = document.createElement("td");
    floorTd.appendChild(document.createTextNode(apt.floor));
    tr.appendChild(floorTd);

    let areaTd = document.createElement("td");
    areaTd.appendChild(document.createTextNode(apt.area));
    tr.appendChild(areaTd);
    
    let dongTd = document.createElement("td");
    dongTd.appendChild(document.createTextNode(apt.dong));
    tr.appendChild(dongTd);
    

    let priceTd = document.createElement("td");
    priceTd.appendChild(
      document.createTextNode(apt.dealdealAmount + "만원")
    );
    tr.appendChild(priceTd);
    
    let buttonTd = document.createElement("td");
    let btn = document.createElement("button");
    btn.setAttribute("class","btn btn-outline-primary");
    btn.innerHTML= "편집";
    btn.onclick = function() {
    	var t = window.location.protocol+"//"+window.location.host +"/"+ window.location.pathname.split("/")[1];
    	console.log(t);
    	window.location.href = t+`/adminHouse/aptDetail/${apt.no}`;
    	return "/admin_aptEdit.jsp";
    }
    buttonTd.appendChild(btn);
    buttonTd.classList.add("text-end");
    tr.appendChild(buttonTd);
    tbody.appendChild(tr);

    
  });
  
}

function parsing(data) {
  let parser = new DOMParser();
  const xml = parser.parseFromString(data, "application/xml");

  let apts = xml.querySelectorAll("item");

  return apts;
}
