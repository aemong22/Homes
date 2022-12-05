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
<c:set var="now" value="4"></c:set>
<body>

	<%@ include file="./common/nav.jsp"%>

	<main id="main" class="main">
	<div class="pagetitle">
		<h1>관심지역 목록</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="index.html">Home</a></li>
				<li class="breadcrumb-item active">관심지역 목록</li>
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
									<b>관심 지역 주변 실거래가</b>
								</h5>

								<!-- Kakao Map start -->
								<div id="map" style="width: 100%; height: 400px"></div>

								<!-- Kakao Map end -->
							</div>
						</div>

						<!-- End Recent Sales -->
					</div>
				</div>

				<div class="col-12">
					<div class="card recent-sales overflow-auto">
						<div class="card-body">
							<h5 class="card-title">
								최근 매매 <span>| 업데이트 2022-09-07 </span>
							</h5>

							<div
								class="dataTable-wrapper dataTable-loading dataTable-empty no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<div class="dataTable-dropdown">
										<label><select class="dataTable-selector"><option
													value="5">5</option>
												<option value="10" selected="">10</option>
												<option value="15">15</option>
												<option value="20">20</option>
												<option value="25">25</option></select> entries per page</label>
									</div>
									<div class="dataTable-search">
									<input type="hidden" id="juso" name="juso" value="">
									<input type="hidden" id="dongCode" name="dongCode" value="">
									<label for="year" style="margin-right:7px;">년도 <input class="dataTable-input"
											type="number" name="year" id="year" value="2022">	</label>
										
									<label for="month">월 <input class="dataTable-input"
											type="number" name="month" id="month" value="3" min="1" max="12"></label>
									<button class="btn btn-outline-primary" onclick="search_data()">검색</button>
										
									</div>
								</div>
								<div class="dataTable-container">
									<table class="table table-borderless datatable dataTable-table"
										style="display: none">
										<thead>
											<tr>
												<th scope="col" data-sortable=""><a href="#"
													class="dataTable-sorter">아파트 이름</a></th>
												<th scope="col" data-sortable=""><a href="#"
													class="dataTable-sorter">층</a></th>
												<th scope="col" data-sortable=""><a href="#"
													class="dataTable-sorter">면적</a></th>
												<th scope="col" data-sortable=""><a href="#"
													class="dataTable-sorter">법정동</a></th>
												<th scope="col" data-sortable=""><a href="#"
													class="dataTable-sorter">거래금액</a></th>
											</tr>
										</thead>

										<tbody id="aptlist">
											<tr>
												<td class="dataTables-empty" colspan="5">No entries
													found</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="dataTable-bottom">
									<div class="dataTable-info"></div>
									<nav class="dataTable-pagination">
										<ul class="dataTable-pagination-list"></ul>
									</nav>
								</div>
							</div>
						</div>
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
									<a><h5>${ concern.juso }</h5></a>
								</div>
							</c:forEach>
						</c:if>
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
	  	concern.push(["${item.juso}","${item.dongCode}"]);
	  </c:forEach>
      //let concerns = document.querySelector(".concerns");
      
      var idx=0;
      concern.forEach(a=>{
        var y; var x;
        geocoder.addressSearch(a[0],function(result, status) {

        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {
            y=result[0].y;
            x=result[0].x;
        }
        });
        var div = divs[idx++];
        
        div.addEventListener("click",function(){
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
          
          document.querySelector("#juso").value=a[0];
          document.querySelector("#dongCode").value=a[1];
          
          var year = document.querySelector("#year").value;
          var month = document.querySelector("#month").value;
          //목록에 표시
          const url = '${root}'+'/houseInfo?code='+a[1]+'&year='+year+'&month='+month;
   	   console.log(url);
   		fetch(url, {
   			method: 'GET'
   		})
   		.then((response)=>response.json()) // 역직렬화 과정
   		.then((data)=>{
   			console.log(data);
   			map_marker2(a[0],data);
   			return makeList(data);
   		});
        });
        
    });

    
    function search_data(){
    	var juso = document.querySelector("#juso").value;
        var code = document.querySelector("#dongCode").value;
        var year = document.querySelector("#year").value;
        var month = document.querySelector("#month").value;
        
    	//목록에 표시
        const url = '${root}'+'/houseInfo?code='+code+'&year='+year+'&month='+month;
    	   console.log(url);
    		fetch(url, {
    			method: 'GET'
    		})
    		.then((response)=>response.json()) // 역직렬화 과정
    		.then((data)=>{
    			map_marker2(juso,data);
    			return makeList(data);
    		});
    }


    
    </script>
	<script src="${root}/assets/js/concern_map.js"></script>
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
