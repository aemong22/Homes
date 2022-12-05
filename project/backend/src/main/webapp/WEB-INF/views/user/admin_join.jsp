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
	<%@ include file="../common/nav.jsp"%>

	<main id="main" class="main">
	<div class="container">

		<div class="pagetitle row justify-content-center">
			<h1>회원 정보 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item">관리자 모드</li>
					<li class="breadcrumb-item active">회원 정보 관리</li>
					<li class="breadcrumb-item active">회원 추가</li>
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
										<h5 class="card-title text-center pb-0 fs-4">Create an
											Account</h5>
										<p class="text-center small">Enter your personal details
											to create account</p>
									</div>

<form id="form-join" class="row g-3 needs-validation"
										novalidate>

										<div class="col-12">
											<label for="yourId" class="form-label">ID</label> <input
												type="text" name="id" class="form-control" id="id" required />
											<div class="invalid-feedback">Please enter a valid Id!</div>
										</div>
										<div id="idcheck-result"></div>


										<div class="col-12">
											<label for="yourPassword" class="form-label">Password</label>
											<input type="password" name="password" class="form-control"
												id="password" placeholder="비밀번호 입력" required />
											<div class="invalid-feedback">Please enter your
												password!</div>
										</div>

										<div class="col-12">
											<label for="yourName" class="form-label">Name</label> <input
												type="text" name="name" class="form-control" id="name"
												placeholder="이름 입력" required />
											<div class="invalid-feedback">Please enter your name!</div>
										</div>

										<div class="col-12">
											<label for="yourAddress" class="form-label">Address</label> <input
												type="text" name="address" class="form-control"
												placeholder="주소 입력" id="address" required />
										</div>

										<div class="col-12">
											<label for="yourPhone" class="form-label">Phone
												Number</label> <input type="text" name="phone" class="form-control"
												placeholder="010-xxxx-xxxx" id="phone" required />
											<div class="invalid-feedback">Please enter your phone
												number!</div>
										</div>

										<div class="col-12">
											<label for="email" class="form-label">이메일 : </label>
											<div class="input-group">
												<input type="text" class="form-control" id="emailid"
													name="emailid" placeholder="이메일아이디" required /> <span
													class="input-group-text">@</span> <select
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
											<button class="btn btn-primary w-100" type="button"
												onclick="join()" id="btn-join">Create Account</button>
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
	<%@ include file="../common/footer.jsp"%>


<script>
      let isUseId = false;
      document.querySelector("#id").addEventListener("keyup", function () {
    	 let userid = this.value;
    	 let resultDiv = document.querySelector("#idcheck-result");
    	 if (userid.length < 5 || userid.length > 16) {
    		 resultDiv.setAttribute("class", "mb-3 text-dark");
    		 resultDiv.textContent = "아이디는 5자 이상 16자 이하 입니다.";
    		 isUseId = false;
    		 document.querySelector("#btn-join").disabled=true;
    	 }
    	 else {
    		 fetch(`${root}/user/idcheck/`+userid)
    		 	.then(response => response.text())
    		 	.then(data => {
    		 		if (data == 0) {
    		 			resultDiv.setAttribute("class", "mb-3 text-primary");
    		 			resultDiv.textContent = userid + "는 사용할 수 있습니다.";
    		 			isUseId = true;
    		 			document.querySelector("#btn-join").disabled=false;
    		 		}
    		 		else {
    		 			resultDiv.setAttribute("class", "mb-3 text-danger");
    		 			resultDiv.textContent = userid + "는 사용할 수 없습니다.";
    		 			isUseId = false;
    		 			document.querySelector("#btn-join").disabled=true;
    		 		}
    		 	});
    	 	}
      }); 
      
    </script>
	<script>
	function join() {
		let joinInfo = {
  			  userId: document.querySelector("#id").value,
  			  userName: document.querySelector("#name").value,
			  userPwd: document.querySelector("#password").value,
			  emailId: document.querySelector("#emailid").value,
			  emailDomain: document.querySelector("#emaildomain").value,
			  phonenumber: document.querySelector("#phone").value,
			  address: document.querySelector("#address").value,
		};
  	  let config = {
      	    method: "POST",
      	    headers: {
      	      "Content-Type": "application/json"
      	    },
      	    body: JSON.stringify(joinInfo),
      	  };

      	  fetch('${root}/admin/join', config)
  	    	.then(response => response.json())
	    	.then(data => {
	     	 location.href = `${root}/admin/`;
	    });
	}
    </script>


</body>

</html>