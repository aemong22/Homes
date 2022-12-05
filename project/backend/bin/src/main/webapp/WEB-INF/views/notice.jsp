<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Pages / Announce - WhereIsMyHome</title>
<%@ include file="./common/header.jsp"%>
<c:set var="now" value="5"></c:set>
<body>
	<%@ include file="./common/nav.jsp"%>

	<main id="main" class="main">

	<div class="pagetitle">
		<h1>공지사항</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/index">Home</a></li>
				<li class="breadcrumb-item">Pages</li>
				<li class="breadcrumb-item active">공지사항</li>
			</ol>
		</nav>
	</div>
	<!-- End Page Title -->

	<section class="section">
		<div class="row">
			<div class="col-lg-6">

				<div class="card">
					<div class="card-body">
						<div class="row card-title">
							<h5 class="col-sm-6">공지사항 목록</h5>

							<div class="col-sm-6">
								<!-- Default Accordion -->
								<div class="mb-3 input-group rounded">
									<input type="hidden" name="act" value="search" />
									<input type="search" class="form-control" placeholder="Search"
										aria-label="Search" id="word" name="word" 
										/>
									<button id="search-button" type="button" onclick="search()"
										class="btn btn-primary">
										<i class="bi bi-search"></i>
									</button>
								</div>
							</div>
						</div>


						<div class="accordion" id="accordionExample">
							<div id = "noticelist"></div>

						</div>
						<!-- End Default Accordion Example -->

					</div>
				</div>

			</div>

			<!-- 공지사항 작성은 관리자로 로그인해야 보이게 할 것임 -->
			<c:if test="${ !empty userinfo  }">
				<div class="col-lg-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">
								<b>공지사항 작성</b>
							</h5>
							<form class="row g-3 needs-validation" novalidate>
								<!-- session에서 userid 가져와야함 -->
								<input type="hidden" id="userId" name="userId" value="${ userinfo.userId }" />
								<div class="col-8">
									<label for="subject" class="form-label">제목</label><input
										type="text" name="subject" class="form-control" id="subject"
										required placeholder="제목" />
									<div class="invalid-feedback">제목을 입력하세요!</div>
								</div>
								<div class="col-8">
									<label for="content" class="form-label">내용</label>
									<textarea class="form-control" id = "content" name="content" required> </textarea>
									<div class="invalid-feedback">내용을 입력하세요!</div>
								</div>
								<div class="col-6">
									<button class="btn btn-primary w-100" type="button" onclick = "writeNotice()">Create
										Notice</button>
								</div>
							</form>

						</div>
					</div>
				</div>
			</c:if>
		</div>
	</section>

	</main>
	<!-- End #main -->
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="./common/footer.jsp"%>
	<script>
	<!--
		window.onload = function(){
			let data = '${search}';
			if(data!=null){
				document.querySelector("#word").value= data;
			}
		}
		function search(){
			var word = document.querySelector("#word").value;
			location.href = '${root}/notice?act=search&word='+word;
		}
	-->
	</script>
	<script>
	// 공지사항 목록 불러오기
	fetch(`${root}/notice/list`)
	  .then(response => response.json())
	  .then(data => makeList(data));
	
	// 로그인한 유저 정보 session 가져오기.
	
	
	function makeList(notices) {
	    let tbody = ``;
	    const userinfo = JSON.parse(sessionStorage.getItem("user"));
	    notices.forEach(function (notice) {
	      
	      tbody += `
				<div class="accordion-item">
				<h2 class="accordion-header" id="heading\${ notice.noticeNo }">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#collapse\${ notice.noticeNo }"
						aria-expanded="false"
						aria-controls="collapse\${ notice.noticeNo }">
						<strong>\${notice.userId }</strong> &nbsp; \${ notice.subject }
					&nbsp;&nbsp;&nbsp; \${notice.registerTime}
					</button>
				</h2>
				<div id="collapse\${ notice.noticeNo }"
					class="accordion-collapse collapse"
					aria-labelledby="heading\${ notice.noticeNo }"
					data-bs-parent="#accordionExample">
					<div class="accordion-body"
						notice-id = "\${notice.noticeNo}">
						\${ notice.content } </br>
							<button type="button" class="btn btn-warning rounded-pill"
								onclick="location.href='${root}/notice/edit/\${ notice.noticeNo }'">수정</button>
							<button type="button" class="btn btn-danger rounded-pill" 
							onclick="if(window.confirm('정말로 삭제하시겠습니까?')){deleteNotice(this)}">
							삭제</button>
					</div>
				</div>
			</div>`;
	    });
	    document.querySelector("#noticelist").innerHTML = tbody;
	  }
	</script>
	<script>
	
	// 공지 - 추가
	function writeNotice() {
		let noticeInfo = {
				userId: document.querySelector("#userId").value,
				subject: document.querySelector("#subject").value,
				content: document.querySelector("#content").value,
		}
		
		let config = {
				method : "POST",
				headers: {
			  	      "Content-Type": "application/json"
		  	    },
		  	    body: JSON.stringify(noticeInfo),
		};
	  	  fetch('${root}/notice/write', config)
	  	    .then(response => response.json())
	  	    .then(data => {
				subject: document.querySelector("#subject").value = "";
				content: document.querySelector("#content").value = "" ;
	  	    	makeList(data)});
	  	    
	}
	
	
	// 공지 - 삭제
	function deleteNotice(el) {
		  let id = el.parentNode.getAttribute("notice-id");
		  let config = {
		    method: "DELETE",
		    headers: {
		      "Content-Type": "application/json"
		    }
		  };
		  fetch(`${root}/notice/remove/\${id}`, config)
		    .then(response => response.json())
		    .then(data => makeList(data));
		}
	</script>
</body>

</html>