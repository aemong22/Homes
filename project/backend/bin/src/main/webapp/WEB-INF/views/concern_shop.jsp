<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<title>Interest - WhereIsMyHome</title>
<%@ include file="./common/header.jsp"%>
<c:if test="${empty userinfo}">
	<script type="text/javascript">
		alert("정상적인 URL 접근이 아닙니다.");
		location.href = "${root}";
	</script>
</c:if>
<c:set var="now" value="6"></c:set>
<body>

	<%@ include file="./common/nav.jsp"%>

	<main id="main" class="main">
	<div class="pagetitle">
		<h1>관심지역 상권</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="index.html">Home</a></li>
				<li class="breadcrumb-item active">관심지역 상권</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section dashboard">
		<div class="row">
			<!-- Left side columns -->
			<div class="col-lg-8">
				<div class="row">
					<!-- Reports -->
					<div class="col-12">
						<div class="card">
							<div class="filter">
								<a class="icon" href="#" data-bs-toggle="dropdown"><i
									class="bi bi-three-dots"></i></a>
								<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
									<li class="dropdown-header text-start">
										<h6>Filter</h6>
									</li>

									<li><a class="dropdown-item" href="#">Today</a></li>
									<li><a class="dropdown-item" href="#">This Month</a></li>
									<li><a class="dropdown-item" href="#">This Year</a></li>
								</ul>
							</div>

							<div class="card-body">
								<h5 class="card-title">
									<b>관심 지역 주변 문화시설</b>
								</h5>

								<!-- Kakao Map start -->
								<div id="map" style="width: 100%; height: 400px"></div>

								<!-- Kakao Map end -->
							</div>
						</div>

						<!-- End Recent Sales -->
					</div>
				</div>
			</div>
			<!-- End Left side columns -->
			<div class="col-lg-4">
				<div class="card">
					<div class="card-body concerns">
						<h5 class="card-title">
							<b>관심지역 목록</b>
						</h5>

						<c:if test="${ concerns ne null }">
							<c:forEach items="${ concerns }" var="concern">
								<div class="mb-3 jusos">
									<a><h5 style="cursor:pointer">${ concern.juso }</h5></a>
								</div>
							</c:forEach>
						</c:if>
					</div>

					<div class="card-body">
						<div class="input-group">

							<select class="form-select" id="shop" name="shop"
								aria-label="문화시설 선택" required>
								<option value="대형마트" selected>대형마트</option>
								<option value="편의점">편의점</option>
								<option value="유치원">유치원</option>
								<option value="학교">학교</option>
								<option value="학원">학원</option>
								<option value="주차장">주차장</option>
								<option value="주유소">주유소</option>
								<option value="지하철역">지하철역</option>
								<option value="은행">은행</option>
								<option value="문화시설">문화시설</option>
								<option value="중개업소">중개업소</option>
								<option value="공공기관">공공기관</option>
								<option value="중개업소">중개업소</option>
								<option value="공공기관">공공기관</option>
								<option value="관광명소">관광명소</option>
								<option value="숙박">숙박</option>
								<option value="음식점">음식점</option>
								<option value="카페">카페</option>
								<option value="병원">병원</option>
								<option value="약국">약국</option>
							</select>
							<button type="button" class="btn btn-outline-primary"
								onclick="search()">검색</button>
						</div>
					</div>
					<div class="card-body">

						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col"></th>
									<th scope="col">이름</th>
									<th scope="col">주소</th>
								</tr>
							</thead>
							<tbody id="shoplist">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	</main>
	<!-- End #main -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0d6bdea2eb0735ecc0dff0c3a7e4add&libraries=services"></script>
	<!--aa15caa120a82ae0585203269abe17c8-->

	<script>
      var mapContainer = document.getElementById("map"), // 지도를 표시할 div
        mapOption = {
          center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
          level: 6, // 지도의 확대 레벨
        };
		
      let divs = document.querySelectorAll(".jusos");
      // 지도를 생성합니다
      var map = new kakao.maps.Map(mapContainer, mapOption);
      var geocoder = new kakao.maps.services.Geocoder();
      
	  var concern = new Array();
      var concern_marks=[];
	  
	  <c:forEach items="${concerns}" var="item">
	  	concern.push("${item.juso}");
	  </c:forEach>
      //let concerns = document.querySelector(".concerns");
      
      var idx=0;
      concern.forEach(a=>{
        var y; var x;
        
        geocoder.addressSearch(a,function(result, status) {

        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
            y=result[0].y;
            x=result[0].x;
        }
        });
        var div = divs[idx++];

        div.addEventListener("click",function(){
         //테이블 초기화
         initTable();
         
          //이전의 마커들 삭제
          for(var i=0;i<concern_marks.length;i++){
            concern_marks[i].setMap(null);
          }
          concern_marks=[];

          var moveLatLon = new kakao.maps.LatLng(y, x);
          
          var imageSrc = '/assets/img/location-pin.png', // 마커이미지의 주소입니다    
              imageSize = new kakao.maps.Size(36, 36), // 마커이미지의 크기입니다
              imageOption = {offset: new kakao.maps.Point(18, 36)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                
          // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
          var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
              markerPosition = moveLatLon; // 마커가 표시될 위치입니다

          var marker = new kakao.maps.Marker({
              position: moveLatLon, 
              image: markerImage // 마커이미지 설정 
          });

          marker.setMap(map); //지도에 마커 표시
          concern_marks.push(marker);


          map.panTo(moveLatLon); 
        });
        
    });

    var markers = [];

    function search(){
    	var id="";
    	var selectOption = document.getElementById("shop");
    	selectOption = selectOption.options[selectOption.selectedIndex].value;
    	
      const url = '${root}'+'/concern/shop_list?shop='+selectOption;
      fetch(url,{
    	method:'GET'  
      })
      .then((response) => response.json())
      .then((data)=>{
    	  data = data.shop
    	//이전의 마커들 삭제
          for(var i=0;i<markers.length;i++){
            markers[i].setMap(null);
          }
          markers=[];

          // 장소 검색 객체를 생성합니다
          var ps = new kakao.maps.services.Places(map); 
    	 
          // 카테고리로 검색합니다
          ps.categorySearch(data, placesSearchCB, {useMapBounds:true}); 
      });
    }

    // 키워드 검색 완료 시 호출되는 콜백함수 입니다
    function placesSearchCB (data, status, pagination) {
     let tbody = document.querySelector("#shoplist");
     
     //테이블 초기화
     initTable();
     
      if (status === kakao.maps.services.Status.OK) {
          for (var i=0; i<data.length; i++) {
        	  displayMarker(data[i]); 
        	  let tr = document.createElement("tr");
        	  let th = document.createElement("th");
        	  th.appendChild(document.createTextNode(i+1));
        	  tr.appendChild(th);
              
        	  let nameTd = document.createElement("td");
        	  nameTd.appendChild(document.createTextNode(data[i].place_name));
        	  tr.appendChild(nameTd);
        	  
        	  let addressTd = document.createElement("td");
        	  addressTd.appendChild(document.createTextNode(data[i].address_name));
        	  tr.appendChild(addressTd);
        	  
        	  tbody.appendChild(tr);
          }       
      }
      
    }

    // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
    var infowindow = new kakao.maps.InfoWindow({zIndex:1});
    
    // 지도에 마커를 표시하는 함수입니다
    function displayMarker(place) {
    	console.log(place);
    	
        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x) 
        });
        markers.push(marker);

        // 마커에 클릭이벤트를 등록합니다
        kakao.maps.event.addListener(marker, 'mouseover', function() {
            // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
            infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
            infowindow.open(map, marker);
        });

         // 마커에 마우스아웃 이벤트를 등록합니다
         kakao.maps.event.addListener(marker, "mouseout", function () {
          // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
          infowindow.close();
        });
    }
    
    function initTable() {
        let tbody = document.querySelector("#shoplist");
        let len = tbody.rows.length;
        for (let i = len - 1; i >= 0; i--) {
          tbody.deleteRow(i);
        }
      }

    
    </script>
	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="copyright">
			&copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights
			Reserved
		</div>
		<div class="credits">
			<!-- All the links in the footer should remain intact. -->
			<!-- You can delete the links only if you purchased the pro version. -->
			<!-- Licensing information: https://bootstrapmade.com/license/ -->
			<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
			Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
		</div>
	</footer>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script src="${root}/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="${root}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="${root}/assets/vendor/chart.js/chart.min.js"></script>
	<script src="${root}/assets/vendor/echarts/echarts.min.js"></script>
	<script src="${root}/assets/vendor/quill/quill.min.js"></script>
	<script src="${root}/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="${root}/assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="${root}/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="${root}/assets/js/main.js"></script>
</body>
</html>
