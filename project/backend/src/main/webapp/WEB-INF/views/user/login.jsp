<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<title>Pages / Login - WhereIsMyHome</title>

<%@ include file="../common/header.jsp"%>
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
										<h5 class="card-title text-center pb-0 fs-4">Login to
											Your Account</h5>
										<p class="text-center small">Enter your username &
											password to login</p>
										<div style="color: red; font-size: 12px; text-align: center">
											<strong>${msg}</strong>
										</div>
									</div>

									<form id="form-login" class="row g-3 needs-validation"
										novalidate>
										<div class="col-12">
											<label for="yourId" class="form-label">ID</label> <input
												type="text" name="userId" class="form-control" id="userId"
												required placeholder="ssafy" />
											<div class="invalid-feedback">Please enter a valid Id!</div>
										</div>

										<div class="col-12">
											<label for="yourPassword" class="form-label">Password</label>
											<input type="password" name="userPassword"
												class="form-control" id="userPassword" required
												placeholder="1234" />
											<div class="invalid-feedback">Please enter your
												password!</div>
										</div>


										<div class="col-12">
											<button class="btn btn-primary w-100" type="button"
												onclick="login()">Login</button>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Don't have account? <a href="${root}/user/join">Create
													an account</a>
											</p>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Forget your password? <a href="pages-find-password.html">Find
													password</a>
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
	<script>
    function login() {
    	  // 서버로 보낼 정보 작성
    	  let loginInfo = {
    			  userId: document.querySelector("#userId").value,
    			  userPwd: document.querySelector("#userPassword").value,
    	  };
    	  let config = {
    	    method: "POST",
    	    headers: {
    	      "Content-Type": "application/json"
    	    },
    	    body: JSON.stringify(loginInfo),
    	  };

    	  fetch('${root}/user/login', config)
    	    .then(response => response.json())
    	    .then(data => {
    	      sessionStorage.setItem("user", JSON.stringify(data));
    	      location.href = `${root}/`;
    	    });
    	};
    </script>

</body>
</html>
