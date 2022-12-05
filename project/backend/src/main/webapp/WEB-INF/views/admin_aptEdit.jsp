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
				<li class="breadcrumb-item"><a href="${root}/index">관리자</a></li>
				<li class="breadcrumb-item">아파트 정보 관리</li>
				<li class="breadcrumb-item active">아파트 정보 편집</li>
			</ol>
		</nav>
	</div>


	<section class="section dashboard row">
		<div class="col-xl-8">
			<div class="card">
				<div class="card-body pt-3">
					<!-- Bordered Tabs -->
					<ul class="nav nav-tabs nav-tabs-bordered">
						<li class="nav-item">
							<button class="nav-link active" data-bs-toggle="tab"
								data-bs-target="#apt-overview">Detail</button>
						</li>

						<li class="nav-item">
							<button class="nav-link" data-bs-toggle="tab"
								data-bs-target="#apt-edit">Edit APT</button>
						</li>

						<li class="nav-item">
							<button class="nav-link" data-bs-toggle="tab"
								data-bs-target="#apt-delete">DELETE</button>
						</li>

					</ul>
					<div class="tab-content pt-2">
						<div class="tab-pane fade show active profile-overview"
							id="apt-overview">
							<h5 class="card-title">APT Details</h5>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">APT NO</div>
								<div class="col-lg-9 col-md-8 user-id">${selectApt.no}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">aptCode</div>
								<div class="col-lg-9 col-md-8 user-pw">${selectApt.aptCode}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">apartmentName</div>
								<div class="col-lg-9 col-md-8 user-name">${selectApt.apartmentName}</div>
							</div>
							<div class="row">
								<div class="col-lg-3 col-md-4 label">buildYear</div>
								<div class="col-lg-9 col-md-8 user-name">${selectApt.buildYear}</div>
							</div>
							<div class="row">
								<div class="col-lg-3 col-md-4 label">dong</div>
								<div class="col-lg-9 col-md-8 user-name">${selectApt.dong}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">dealAmount</div>
								<div class="col-lg-9 col-md-8 user-addr">${selectApt.dealdealAmount}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">floor</div>
								<div class="col-lg-9 col-md-8 user-addr">${selectApt.floor}</div>
							</div>

							<div class="row">
								<div class="col-lg-3 col-md-4 label">area</div>
								<div class="col-lg-9 col-md-8 user-addr">${selectApt.area}</div>
							</div>


						</div>

						<div class="tab-pane fade profile-edit pt-3" id="apt-edit">
							<!-- Profile Edit Form -->
							<form id="form-join" method="post" action="${root}/admin/adminHouse/aptEdit/${selectApt.no}"
								class="row g-3 needs-validation" novalidate>
								<!-- <input type="hidden" name="act" value="aptEdit"> -->
								<div class="col-12">
									<label for="deal" class="form-label">Password</label> <input
										type="text" name="dealAmount" class="form-control" id="deal"
										placeholder="실거래가 입력하세요." required />
									<button class="btn btn-primary m-3" type="submit"
										id="apt-edit">Yes</button>
								</div>
							</form>
							<!-- End Profile Edit Form -->
						</div>

						<div class="tab-pane fade pt-3" id="apt-delete">
							<!-- Resign Form -->
							<form method="get" action="${root}/admin/adminHouse/aptDelete/${selectApt.no}">
								<!-- <input type="hidden" name="act" value="aptDelete"> -->
								<div class="row mb-3">
									<label for="fullName" class="col-md-4 col-lg-3 col-form-label">아파트 매매 정보 삭제</label>
									<div class="col-md-8 col-lg-9">
										<div class="form-check">
											<label class="form-check-label" for="newProducts">
												정말로 정보를 삭제하시겠습니까? </label>
											<button class="btn btn-primary m-3" type="submit"
												id="resign-button">Yes</button>
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
										class="col-md-4 col-lg-3 col-form-label">New Password</label>
									<div class="col-md-8 col-lg-9">
										<input name="newpassword" type="password" class="form-control"
											id="newPassword" />
									</div>
								</div>

								<div class="row mb-3">
									<label for="renewPassword"
										class="col-md-4 col-lg-3 col-form-label">Re-enter New
										Password</label>
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
	</section>


	</main>
	<!-- End #main -->
	<%@ include file="./common/footer.jsp"%>
</body>
</html>
