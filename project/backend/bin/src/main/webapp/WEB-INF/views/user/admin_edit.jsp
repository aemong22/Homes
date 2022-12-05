<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Pages / Announce - WhereIsMyHome</title>
<%@ include file="../common/header.jsp"%>
<body>
	<%@ include file="/common/nav.jsp"%>

	<main id="main" class="main">
	<div class="container-fluid">

		<div class="pagetitle row justify-content-center">
			<h1>회원 정보 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">관리자 모드</li>
					<li class="breadcrumb-item active">회원 정보 관리</li>
					<li class="breadcrumb-item active">회원 정보 수정</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

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
									class="d-none d-lg-block">관리자 모드</span>
								</a>
							</div>
							<!-- End Logo -->

							<div class="card mb-3">
								<div class="card-body">
									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">회원 정보 수정</h5>
									</div>
									<form id="form-admin-edit" method="post" action="${root}/user"
										class="row g-3 needs-validation" novalidate>
										<input type="hidden" name="act" value="memberEdit">

										<div class="col-12">
											<label for="yourId" class="form-label">ID</label> <input
												type="text" name="id" class="form-control" id="id"
												value = "${selectMember.userId}" disabled />
											<div class="invalid-feedback">Please enter a valid Id!</div>
										</div>
										<div id="idcheck-result"></div>


										<div class="col-12">
											<label for="yourPassword" class="form-label">Password</label>
											<input type="text" name="password" class="form-control"
												id="password" placeholder="${selectMember.userPwd}" required />
											<div class="invalid-feedback">Please enter your
												password!</div>
										</div>

										<div class="col-12">
											<label for="yourName" class="form-label">Name</label> <input
												type="text" name="name" class="form-control" id="name"
												placeholder="${selectMember.userName}" required />
											<div class="invalid-feedback">Please enter your name!</div>
										</div>

										<div class="col-12">
											<label for="yourAddress" class="form-label">Address</label> <input
												type="text" name="address" class="form-control"
												placeholder="${selectMember.address}" id="address" required />
										</div>

										<div class="col-12">
											<label for="yourPhone" class="form-label">Phone
												Number</label> <input type="text" name="phone" class="form-control"
												placeholder="${selectMember.phonenumber}" id="phone"
												required />
											<div class="invalid-feedback">Please enter your phone
												number!</div>
										</div>

										<div class="col-12">
											<label for="email" class="form-label">이메일 : </label>
											<div class="input-group">
												<input type="text" class="form-control" id="emailid"
													name="emailid" placeholder="${selectMember.emailId}"
													required /> <span class="input-group-text">@</span> <select
													class="form-select" id="emaildomain" name="emaildomain"
													aria-label="이메일 도메인 선택" required>
													<option value="">선택</option>
													<option value="ssafy.com">ssafy.com</option>
													<option value="google.com">google.com</option>
													<option value="naver.com">naver.com</option>
													<option value="kakao.com">kakao.com</option>
												</select>
											</div>
											<div class="invalid-feedback">Please enter your email!</div>
										</div>


										<div class="col-12">
											<button class="btn btn-primary w-100" type="submit"
												id="btn-edit">회원정보 수정</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>


	</div>
	</main>
	<!-- End #main -->
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="/common/footer.jsp"%>


	<script>
      let isUseId = false;
      document.querySelector("#id").addEventListener("keyup", function () {
    	 let userid = this.value;
    	 let resultDiv = document.querySelector("#idcheck-result");
    	 if (userid.length < 5 || userid.length > 16 || userid.length == 0) {
    		 resultDiv.setAttribute("class", "mb-3 text-dark");
    		 resultDiv.textContent = "아이디는 5자 이상 16자 이하 입니다.";
    		 isUseId = false;
    		 document.querySelector("#btn-edit").disabled=true;
    		 console.log(userid);
    	 }
    	 else {
    		 fetch("${ root }/user?act=idcheck&userid="+userid)
    		 	.then(response => response.text())
    		 	.then(data => {
    		 		if (data == 0) {
    		 			resultDiv.setAttribute("class", "mb-3 text-primary");
    		 			resultDiv.textContent = userid + "는 사용할 수 있습니다.";
    		 			isUseId = true;
    		 			document.querySelector("#btn-edit").disabled=false;
    		 		}
    		 		else {
    		 			resultDiv.setAttribute("class", "mb-3 text-danger");
    		 			resultDiv.textContent = userid + "는 사용할 수 없습니다.";
    		 			isUseId = false;
    		 			document.querySelector("#btn-edit").disabled=true;
    		 		}
    		 	});
    	 }
      });
      
    </script>

</body>

</html>