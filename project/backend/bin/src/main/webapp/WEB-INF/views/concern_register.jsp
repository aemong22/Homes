<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <%@ include file="./common/header.jsp" %>
  <c:if test="${empty userinfo}">
	<script type="text/javascript">
		alert("정상적인 URL 접근이 아닙니다.");
		location.href = "${root}";
	</script>
</c:if>
  <body>
    <main>
      <div class="container">
        <section
          class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4"
        >
          <div class="container">
            <div class="row justify-content-center">
              <div
                class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center"
              >
                <div class="d-flex justify-content-center py-4">
                  <a href="${root}/houseInfo/mvapt" class="logo d-flex align-items-center w-auto">
                    <img src="/assets/img/logo.png" alt="" />
                    <span class="d-none d-lg-block">NiceAdmin</span>
                  </a>
                </div>
                <!-- End Logo -->

                <div class="card mb-3">
                  <div class="card-body">
                    <div class="pt-4 pb-2">
                      <h5 class="card-title text-center pb-0 fs-4">관심 지역 등록</h5>
                      <p class="text-center small">관심 지역 설정</p>
                    </div>

                    <form method="post" action="${ root }/concern" class="row g-3 needs-validation" id="juso_frm" novalidate>
                    <input type="hidden" name="juso" id="juso" value=""/>
                      <div class="col-12 mb-3">
                        <div class="d-flex align-items-center">
                          <select class="form-select bg-light" id="sido" name="sido">
                            <option value="none">시도선택</option>
                          </select>
                        </div>
                      </div>

                      <div class="col-12 mb-3">
                        <div class="d-flex align-items-center">
                          <select class="form-select bg-light" id="gugun" name="gugun">
                            <option value="none">구군선택</option>
                          </select>
                        </div>
                      </div>

                      <div class="col-12 mb-3">
                        <div class="d-flex align-items-center">
                          <select class="form-select bg-light" id="dong" name="dong">
                            <option value="none">동선택</option>
                          </select>
                        </div>
                      </div>

                      <div class="col-12">
                        <button class="btn btn-primary w-100" type="button" onClick="register()">등록</button>
                      </div>
                      <div class="col-12">
                        <p class="small mb-0" style="text-align: center">
                          <a href="#" onclick="history.back()">돌아가기</a>
                        </p>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
    <!-- End #main -->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>
    
    
    <script>
   ///////////////////////// select box 설정 (지역, 매매기간) /////////////////////////
   let date = new Date();

   window.onload = function () {
     // 브라우저가 열리면 시도정보 얻기.
     // 시도 정보 얻기
		const url = '${root}'+'/rest/house/sido';
		fetch(url, {
			method: 'GET'
		})
		.then((response)=>response.json()) // 역직렬화 과정
		.then((data)=>{
			addOption("sido",data)});
   };

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
   
   function register(){
 	  let sido= document.querySelector("#sido");
 	  const sido_txt = sido.options[sido.selectedIndex].text;
 	  
 	  let gugun= document.querySelector("#gugun");
 	  const gugun_txt = gugun.options[gugun.selectedIndex].text;
 	  
 	  let dong= document.querySelector("#dong");
 	  const dong_txt = dong.options[dong.selectedIndex].text;
 	  
 	  if(sido.selectedIndex==0 || gugun.selectedIndex==0 || dong.selectedIndex==0){
 		  alert("주소를 선택하세요!!");
 	  }
 	  else{
 		  let txt = sido_txt+" "+gugun_txt+" "+dong_txt;
 		  document.querySelector("#juso").value=txt;
 		  
 		  document.getElementById('juso_frm').submit();
 	  }
   }


   function initOption(selid) {
     let options = document.querySelector(`#\${selid}`);
     options.length = 0;
   }

   
   function initTable() {
     let tbody = document.querySelector("#aptlist");
     let len = tbody.rows.length;
     for (let i = len - 1; i >= 0; i--) {
       tbody.deleteRow(i);
     }
   }

   </script>
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
    <script src="${root }/assets/js/main.js"></script>
  </body>
</html>
