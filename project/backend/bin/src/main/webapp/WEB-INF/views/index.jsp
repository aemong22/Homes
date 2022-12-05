<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<title>SSAFY - WhereIsMyHome</title>

<%@ include file="./common/header.jsp"%>
<c:set var="now" value="1"></c:set>
<body>
	<%@ include file="./common/nav.jsp"%>

	<main id="main" class="main">
	<div class="pagetitle">
		<h1>아파트</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/">Home</a></li>
				<li class="breadcrumb-item active">아파트</li>
			</ol>
		</nav>
		<button type="button" id="list-btn" class="btn btn-outline-primary">
			매매정보 검색</button>

	</div>
	<!-- End Page Title -->

	<section class="section dashboard">
		<div class="row">
			<!-- Left side columns -->
			<div class="col-lg-10">
				<div class="row">
					<!-- 시도 선택 Card -->
					<div class="col-xxl-2 col-md-6">
						<div class="card info-card sales-card">
							<div class="card-body">
								<h5 class="card-title">
									시도 <span>| Sido</span>
								</h5>
								<div class="d-flex align-items-center">
									<select class="form-select bg-secondary text-light" id="sido">
										<option value="">시도선택</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!-- End Sales Card -->

					<!-- 시도 선택 Card -->
					<div class="col-xxl-2 col-md-6">
						<div class="card info-card sales-card">
							<div class="card-body">
								<h5 class="card-title">
									구군 <span>| Gugun</span>
								</h5>

								<div class="d-flex align-items-center">
									<select class="form-select bg-secondary text-light" id="gugun">
										<option value="">구군선택</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!-- End Sales Card -->

					<!-- 시도 선택 Card -->
					<div class="col-xxl-2 col-md-6">
						<div class="card info-card sales-card">
							<div class="card-body">
								<h5 class="card-title">
									동 <span>| Dong</span>
								</h5>

								<div class="d-flex align-items-center">
									<select class="form-select bg-secondary text-light" id="dong">
										<option value="">동선택</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!-- End Sales Card -->

					<!-- 시도 선택 Card -->
					<div class="col-xxl-2 col-md-6">
						<div class="card info-card sales-card">
							<div class="card-body">
								<h5 class="card-title">
									매매년도 <span>| Year</span>
								</h5>

								<div class="d-flex align-items-center">
									<select class="form-select bg-dark text-light" id="year">
										<option value="">매매년도</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!-- End Sales Card -->

					<!-- 시도 선택 Card -->
					<div class="col-xxl-2 col-md-6">
						<div class="card info-card sales-card">
							<div class="card-body">
								<h5 class="card-title">
									매매월 <span>| Month</span>
								</h5>

								<div class="d-flex align-items-center">
									<select class="form-select bg-dark text-light" id="month">
										<option value="">매매월</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<!-- End Sales Card -->

					<!-- <div class="col-12">
                <button type="button" id="list-btn" class="btn btn-outline-primary">
                  매매정보가져오기
                </button>
              </div> -->

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
									<b>아파트 실거래가 조회</b> <span>| 업데이트 2022-09-07</span>
								</h5>

								<!-- Kakao Map start -->
								<div id="map" style="width: 100%; height: 400px"></div>

								<!-- Kakao Map end -->
							</div>
						</div>
					</div>
					<!-- End Reports -->

					<!-- Recent Sales -->
					<div class="col-12">
						<div class="card recent-sales overflow-auto">
							<div class="card-body">
								<h5 class="card-title d-flex justify-content-between">
									<div>
										최근 매매 <span> | 업데이트 2022-09-07 </span>
									</div>
									<div>
										<button class="btn sort-btn  btn-outline-info btn-sm"
											value="area" onclick="sort_area(`area`)">면적순</button>
										<button class="btn sort-btn  btn-outline-info btn-sm"
											value="dealAmount" onclick="sort_area(`dealAmount`)">거래금액순</button>
									</div>
								</h5>
								<div class="col-md-4 mb-3">
									<input type="text" id="user_deal" name="user_deal" value=""
										placeholder="거래금액을 입력해주세요." />
									<button class="btn btn-outline-primary" onclick="search_data()">검색</button>
								</div>

								<table class="table table-borderless" style="display: none">
									<thead>
										<tr>
											<th scope="col" data-sortable="">아파트 이름</th>
											<th scope="col" data-sortable="">층</th>
											<th scope="col">면적</th>
											<th scope="col" data-sortable="">법정동</th>
											<th scope="col" data-sortable="">거래금액</th>
										</tr>
									</thead>

									<tbody id="aptlist"></tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- End Recent Sales -->
				</div>
			</div>
			<!-- End Left side columns -->
		</div>
	</section>
	</main>
	<!-- End #main -->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a0d6bdea2eb0735ecc0dff0c3a7e4add&libraries=services"></script>

	<script>
   ///////////////////////// select box 설정 (지역, 매매기간) /////////////////////////
   let date = new Date();

   window.onload = function () {
     let yearEl = document.querySelector("#year");
     let yearOpt = `<option value="">매매년도선택</option>`;
     let year = date.getFullYear();
     for (let i = year; i > year - 20; i--) {
       yearOpt += `<option value="\${i}">\${i}년</option>`;
     }
     yearEl.innerHTML = yearOpt;

     // 브라우저가 열리면 시도정보 얻기.
     // 시도 정보 얻기
		const url = '${root}'+'/rest/house/sido';
		fetch(url, {
			method: 'GET'
		})
		.then((response)=>response.json()) // 역직렬화 과정
		.then((data)=>{
			console.log(data);
			addOption("sido",data)});
   };

   document.querySelector("#year").addEventListener("change", function () {
     let month = date.getMonth() + 1;
     let monthEl = document.querySelector("#month");
     let monthOpt = `<option value="">매매월선택</option>`;
     let yearSel = document.querySelector("#year");
     let m = yearSel[yearSel.selectedIndex].value == date.getFullYear() ? month : 13;
     for (let i = 1; i < m; i++) {
       monthOpt += `<option value="\${i < 10 ? "0" + i : i}">\${i}월</option>`;
     }
     monthEl.innerHTML = monthOpt;
   });

   // 시도가 바뀌면 구군정보 얻기.
   document.querySelector("#sido").addEventListener("change", function () {
     if (this[this.selectedIndex].value) {
    	 let regcode = this[this.selectedIndex].value;
    	 const url = '${root}'+'/rest/house/gugun?sidoCode='+regcode;
 		fetch(url, {
 			method: 'GET'
 		})
 		.then((response)=>response.json()) // 역직렬화 과정
 		.then((data)=>{
 			addOption("gugun",data)});
     } else {
       initOption("gugun");
       initOption("dong");
     }
   });

   // 구군이 바뀌면 동정보 얻기.
   document.querySelector("#gugun").addEventListener("change", function () {
     if (this[this.selectedIndex].value) {
    	 let regcode = this[this.selectedIndex].value;
    	 const url = '${root}'+'/rest/house/dong?gugunCode='+regcode;
 		fetch(url, {
 			method: 'GET'
 		})
 		.then((response)=>response.json()) // 역직렬화 과정
 		.then((data)=>{
 			addOption("dong",data)});
    	 
     } else {
       initOption("dong");
     }
   });

   function addOption(selid, data) {
     let opt = ``;
     initOption(selid);
     switch (selid) {
       case "sido":
         opt += `<option value="">시도선택</option>`;
         data.forEach(function(sido) {
        	 opt += `
             <option value="\${sido.dongCode}">\${sido.sidoName}</option>
             `;
         });
         break;
       case "gugun":
         opt += `<option value="">구군선택</option>`;
         data.forEach(function(gugun) {
        	 opt += `
             <option value="\${gugun.dongCode}">\${gugun.gugunName}</option>
             `;
         });
         break;
       case "dong":
         opt += `<option value="">동선택</option>`;
         data.forEach(function(dong) {
        	 opt += `
             <option value="\${dong.dongCode}">\${dong.dongName}</option>
             `;
         });
         break;
     }
     document.querySelector(`#\${selid}`).innerHTML = opt;
   }

   function initOption(selid) {
     let options = document.querySelector(`#\${selid}`);
     options.length = 0;
   }

   // /////////////////////// 아파트 매매 정보 /////////////////////////
   document.querySelector("#list-btn").addEventListener("click", function () {
     let dongSel = document.querySelector("#dong");
     let dongCode=  dongSel[dongSel.selectedIndex].value;
     let yearSel = document.querySelector("#year");
     let year = yearSel[yearSel.selectedIndex].value;
     let monthSel = document.querySelector("#month");
     let month = monthSel[monthSel.selectedIndex].value;
     
	   const url = '${root}'+'/houseInfo?code='+dongCode+'&year='+year+'&month='+month;
	   console.log(url);
		fetch(url, {
			method: 'GET'
		})
		.then((response)=>response.json()) // 역직렬화 과정
		.then((data)=>{
			console.log(data);
			map_marker(data);
			return makeList(data);
		});
   });
   
   function sort_area(selectSort) {
	     let dongSel = document.querySelector("#dong");
	     let dongCode=  dongSel[dongSel.selectedIndex].value;
	     let yearSel = document.querySelector("#year");
	     let year = yearSel[yearSel.selectedIndex].value;
	     let monthSel = document.querySelector("#month");
	     let month = monthSel[monthSel.selectedIndex].value;
	     let sort = selectSort;
	     console.log(sort);
	     
		   const url = '${root}'+'/houseInfoSort?code='+dongCode+'&year='+year+'&month='+month+'&sort='+sort;
		   console.log(url);
			fetch(url, {
				method: 'GET'
			})
			.then((response)=>response.json()) // 역직렬화 과정
			.then((data)=>{
				console.log(data);
				// map_marker(data);
				return makeList(data);
			});
	   };
	   
	   function search_data() {
		     let dongSel = document.querySelector("#dong");
		     let dongCode=  dongSel[dongSel.selectedIndex].value;
		     let yearSel = document.querySelector("#year");
		     let year = yearSel[yearSel.selectedIndex].value;
		     let monthSel = document.querySelector("#month");
		     let month = monthSel[monthSel.selectedIndex].value;
		     let sort = "dealAmount";
		     let user_deal = document.querySelector("#user_deal").value;
		     console.log("user_deal : " + user_deal);    
		     
			   const url = '${root}'+'/houseInfoSort?code='+dongCode+'&year='+year+'&month='+month+'&sort='+sort+'&user_deal='+user_deal;
			   console.log(url);
				fetch(url, {
					method: 'GET'
				})
				.then((response)=>response.json()) // 역직렬화 과정
				.then((data)=>{
					console.log(data);
					map_marker(data);
					return makeList(data);
				});
		   };
   
   

   </script>
	<script src="${root}/assets/js/index_map.js"></script>
	<footer id="footer" class="footer">
		<div class="copyright">
			&copy; Copyright <strong><span>SSAFY</span></strong>. All Rights
			Reserved
		</div>
		<div class="credits">
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
