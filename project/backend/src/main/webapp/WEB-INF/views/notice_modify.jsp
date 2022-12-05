<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<title>Pages / Login - WhereIsMyHome</title>
<%@ include file="./common/header.jsp"%>
<body>
	<main>
	<div class="container">
		<section
			class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
			<div class="container">
				<div class="row justify-content-center">
					<div
						class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
						<div class="d-flex justify-content-center py-4">
							<a href="index.html"
								class="logo d-flex align-items-center w-auto"> <img
								src="assets/img/logo.png" alt="" /> <span
								class="d-none d-lg-block">NiceAdmin</span>
							</a>
						</div>
						<!-- End Logo -->

						<div class="card mb-3">
							<div class="card-body">
								<div class="pt-4 pb-2">
									<h5 class="card-title text-center pb-0 fs-4">글 수정</h5>
								</div>

								<form method="post" action="${ root }/notice" class="row g-3 needs-validation" novalidate>
									<input type="hidden" name=act value="put" />
									<input type="hidden" name="noticeNo" value="${ notice.noticeNo }" />
									<div class="col-12">
										<label for="subject" class="form-label">제목</label><input
											type="text" name="subject" class="form-control" id="subject"
											required placeholder="제목" value="${ notice.subject }" />
										<div class="invalid-feedback">제목을 입력하세요!</div>
									</div>

									<div class="col-12">
										<label for="content" class="form-label">내용</label>
										<textarea class="form-control" name="content" required id = "content">${ notice.content }</textarea>
										<div class="invalid-feedback">내용을 입력하세요!</div>
									</div>


									<div class="col-6">
										<button class="btn btn-primary w-100" type="button" onclick = "editNotice()" >수정</button>
									</div>
									<div class="col-6">
										<button class="btn btn-primary w-100" type="button"
											onclick="location.href='${root}/notice/'">취소</button>
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
	<!-- 유저 정보 -->
    <!-- <script src="${ root }/assets/js/user_profile.js"></script>-->

    <!-- Vendor JS Files -->
    <script src="${ root }/assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="${ root }/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${ root }/assets/vendor/chart.js/chart.min.js"></script>
    <script src="${ root }/assets/vendor/echarts/echarts.min.js"></script>
    <script src="${ root }/assets/vendor/quill/quill.min.js"></script>
    <script src="${ root }/assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="${ root }/assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="${ root }/assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="${ root }/assets/js/main.js"></script>
    
    <script>
    function editNotice() {
    	let editInfo = {
    		noticeNo : window.location.href.split("/")[5],
    		userId : JSON.parse(sessionStorage.getItem("user")).userId,
    		subject : document.querySelector("#subject").value,
    		content : document.querySelector("#content").value,
    	}
		let config = {
				method : "PUT",
				headers: {
			  	      "Content-Type": "application/json"
		  	    },
		  	    body: JSON.stringify(editInfo),
		};
	  	fetch('${root}/notice/edit', config)
	  	    .then(() => {
	  	    location.href = `${root}/notice/`
	  	});	
    }
    </script>
</body>
</html>
