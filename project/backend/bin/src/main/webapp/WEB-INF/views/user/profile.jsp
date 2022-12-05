<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />

<title>Users / Profile - WhereIsMyHome</title>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<%@ include file="../common/nav.jsp"%>


	<main id="main" class="main">
		<div class="pagetitle">
			<h1>Profile</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item">Users</li>
					<li class="breadcrumb-item active">Profile</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section profile">
			<div class="row">
				<div class="col-xl-4">
					<div class="card">
						<div
							class="card-body profile-card pt-4 d-flex flex-column align-items-center">
							<img src="assets/img/profile-img.png" alt="Profile"
								class="rounded-circle" />
							<h2 id="loginUser" class="user-id"></h2>
						</div>
					</div>
				</div>

				<div class="col-xl-8">
					<div class="card">
						<div class="card-body pt-3">
							<!-- Bordered Tabs -->
							<ul class="nav nav-tabs nav-tabs-bordered">
								<li class="nav-item">
									<button class="nav-link active" data-bs-toggle="tab"
										data-bs-target="#profile-overview">Overview</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-edit">Edit Profile</button>
								</li>

								<li class="nav-item">
									<button class="nav-link" data-bs-toggle="tab"
										data-bs-target="#profile-resign">Resign</button>
								</li>

							</ul>
							<div class="tab-content pt-2">
								<div class="tab-pane fade show active profile-overview"
									id="profile-overview">
									<h5 class="card-title">Profile Details</h5>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">ID</div>
										<div id="userId" class="col-lg-9 col-md-8 user-id"></div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Password</div>
										<div id="userPwd" class="col-lg-9 col-md-8 user-pw"></div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Name</div>
										<div id="userName" class="col-lg-9 col-md-8 user-name"></div>
									</div>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">Email</div>
										<div id="userEmail" class="col-lg-9 col-md-8 user-name"></div>
									</div>
									<div class="row">
										<div class="col-lg-3 col-md-4 label">Phone</div>
										<div id="userPhone" class="col-lg-9 col-md-8 user-name"></div>
									</div>

									<div class="row">
										<div class="col-lg-3 col-md-4 label">Address</div>
										<div id="userAddress" class="col-lg-9 col-md-8 user-addr"></div>
									</div>

								</div>



								<div class="tab-pane fade profile-edit pt-3" id="profile-edit">
									<!-- Profile Edit Form -->
									<form id="form-join"
										class="row g-3 needs-validation" novalidate>
										<div class="col-12">
											<label for="yourId" class="form-label">ID</label> <input
												type="text" name="id" class="form-control" id="id" disabled />
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
												id="edit-profile" onclick = "editProfile()">회원정보 수정</button>
										</div>
									</form>
									<!-- End Profile Edit Form -->
								</div>

								<div class="tab-pane fade pt-3" id="profile-resign">
									<!-- Resign Form -->
									<form method="post" action="${root}/user">
										<input type="hidden" name="act" value="resign">
										<div class="row mb-3">
											<label for="fullName"
												class="col-md-4 col-lg-3 col-form-label">Resign
												Membership</label>
											<div class="col-md-8 col-lg-9">
												<div class="form-check">
													<label class="form-check-label" for="newProducts">
														정말로 탈퇴하시겠습니까? </label>
													<button class="btn btn-primary m-3" type="button"
														id="resign-button" onclick = "deleteMember()">Yes</button>
												</div>
											</div>
										</div>
									</form>
									<!-- End settings Form -->
								</div>

								<div class="tab-pane fade pt-3" id="profile-change-password">
									<!-- Change Password Form -->
									<form>
										<div class="row mb-3">
											<label for="currentPassword"
												class="col-md-4 col-lg-3 col-form-label">Current
												Password</label>
											<div class="col-md-8 col-lg-9">
												<input name="password" type="password" class="form-control"
													id="currentPassword" />
											</div>
										</div>

										<div class="row mb-3">
											<label for="newPassword"
												class="col-md-4 col-lg-3 col-form-label">New
												Password</label>
											<div class="col-md-8 col-lg-9">
												<input name="newpassword" type="password"
													class="form-control" id="newPassword" />
											</div>
										</div>

										<div class="row mb-3">
											<label for="renewPassword"
												class="col-md-4 col-lg-3 col-form-label">Re-enter
												New Password</label>
											<div class="col-md-8 col-lg-9">
												<input name="renewpassword" type="password"
													class="form-control" id="renewPassword" />
											</div>
										</div>

										<div class="text-center">
											<button type="submit" class="btn btn-primary">Change
												Password</button>
										</div>
									</form>
									<!-- End Change Password Form -->
								</div>
							</div>
							<!-- End Bordered Tabs -->
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->

	<%@ include file="../common/footer.jsp"%>
	<script>
		// 회원 정보 가져오기
		const userInfo = JSON.parse(sessionStorage.getItem("user"));
		console.log(userInfo.userId);
		fetch('${root}/user/mypage/'+userInfo.userId)
		.then(response => response.json())
		.then(data => {
            document.querySelector("#userId").innerText = data.userId;
            document.querySelector("#userName").innerText = data.userName;
            document.querySelector("#userPwd").innerText = data.userPwd;
            document.querySelector("#userPhone").innerText = data.phonenumber;
            document.querySelector("#userAddress").innerText = data.address;
            document.querySelector("#userEmail").innerText = data.emailId + '@' + data.emailDomain;
            document.querySelector("#loginUser").innerText = data.userName;
            document.querySelector("#id").value = data.userId;
		});
		
	</script>
	<script>
    function editProfile() {
  	  // 서버로 보낼 정보 작성
  	  let editInfo = {
  			userId: document.querySelector("#id").value,
  			userPwd: document.querySelector("#password").value,
  			userName: document.querySelector("#name").value,
  			emailId: document.querySelector("#emailid").value,
  			emailDomain: document.querySelector("#emaildomain").value,
  			address: document.querySelector("#address").value,
  			phonenumber: document.querySelector("#phone").value,
  	  };
  	  let config = {
  	    method: "PUT",
  	    headers: {
  	      "Content-Type": "application/json"
  	    },
  	    body: JSON.stringify(editInfo),
  	  };

  	  fetch('${root}/user/mypage/edit', config)
  	    .then(response => response.json())
  	    .then(data => {
  	      sessionStorage.setItem("user", JSON.stringify(data));
  	      location.href = `${root}/user/mypage`;
  	    });
  	};
	</script>
	
	<script>
	function deleteMember() {
	  	  let config = {
	  	  	    method: "DELETE",
	  	  	    headers: {
	  	  	      "Content-Type": "application/json"
	  	  	    },
	  	  	  };
		fetch('${root}/user/mypage/delete/' + userInfo.userId,config)
		.then(response => {
			sessionStorage.removeItem("user");
			location.href = `${root}/`;
		})
	}
	</script>
</body>
</html>

