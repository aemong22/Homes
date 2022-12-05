<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ======= Header ======= -->
<header id="header" class="header fixed-top d-flex align-items-center">
	<div class="d-flex align-items-center justify-content-between">
		<a href="${root}/houseInfo/mvapt" class="logo d-flex align-items-center"><img
			src="${root}/assets/img/logo.png" alt="" /> <span class="d-none d-lg-block">Where
				Is My Home</span>
		</a> <i class="bi bi-list toggle-sidebar-btn"></i>
	</div>
	<!-- End Logo -->

	<!-- <div class="search-bar">
		<form class="search-form d-flex align-items-center" method="POST"
			action="#">
			<input type="text" name="query" placeholder="Search"
				title="Enter search keyword" />
			<button type="submit" title="Search">
				<i class="bi bi-search"></i>
			</button>
		</form>
	</div>
	-->
	<!-- End Search Bar -->

	<nav class="header-nav ms-auto">
		<ul class="d-flex align-items-center">
			<li class="nav-item d-block d-lg-none"><a
				class="nav-link nav-icon search-bar-toggle" href="#"> <i
					class="bi bi-search"></i>
			</a></li>
			<!-- End Search Icon-->
			<c:if test="${empty userinfo}">
				<li class="nav-item pe-4"><a class="nav-link collapsed"
					href="${root}/user/join"> <i class="bi bi-card-list"></i> <span>Register</span>
				</a></li>
				<!-- End Register Page Nav -->

				<li class="nav-item pe-4"><a class="nav-link collapsed"
					href="${root}/user/login"> <i
						class="bi bi-box-arrow-in-right"></i> <span>Login</span>
				</a></li>
			</c:if>
			<c:if test="${!empty userinfo}">
				<li class="nav-item pe-4 collapsed"><strong>${userinfo.userName}님</strong></li>
				<li class="nav-item pe-4"><a class="nav-link collapsed"
					href="${root}/user/logout" onclick = "logout()"> <i class="bi bi-card-list"></i>
						<span>Logout</span>
				</a></li>
				<li class="nav-item pe-4"><a class="nav-link collapsed"
					href="${root}/user/mypage"> <i class="bi bi-card-list"></i>
						<span>MyPage</span>
				</a></li>
				<c:if test ="${userinfo.admin}">
				<li class="nav-item pe-4"><a class="nav-link collapsed"
					href="${root}/admin/"> <i class="bi bi-card-list"></i>
						<span>관리자(회원관리)</span>
				</a></li>
				</c:if>

			</c:if>
			<!-- End Profile Nav -->
		</ul>
	</nav>
	<!-- End Icons Navigation -->
</header>
<!-- End Header -->

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">
	<ul class="sidebar-nav" id="sidebar-nav">
		<li class="nav-item"><a class="nav-link <c:if test="${now!=1}">collapsed</c:if>" href="${ root }/houseInfo/mvapt"> <i
				class="bi bi-grid"></i> <span>아파트 매매거래</span>
		</a></li>
		<!-- End Dashboard Nav -->
	
		<li class="nav-item"><a class="nav-link <c:if test="${now!=2}">collapsed</c:if>" href="${ root }/houseInfo/mvjutaek"> <i
				class="bi bi-grid"></i> <span>연립다세대 매매거래</span>
		</a></li>
		
		<!-- End Profile Page Nav -->
		
		<c:if test="${!empty userinfo}">
		<li class="nav-item"><a class="nav-link <c:if test="${now!=3}">collapsed</c:if>"
			href="${ root }/concern/register"> <i class="bi bi-journal-check"></i> <span>관심
					지역 등록</span>
		</a></li>
		<!-- End F.A.Q Page Nav -->

		<li class="nav-item"><a class="nav-link <c:if test="${now!=4}">collapsed</c:if>"
			href="${ root }/concern/list"> <i class="bi bi-journal-bookmark"></i> <span>관심
					지역 목록</span>
		</a></li>
		
		<li class="nav-item"><a class="nav-link <c:if test="${now!=6}">collapsed</c:if>"
			href="${ root }/concern/shop"> <i class="bi bi-journal-bookmark"></i> <span>관심
					지역 상권</span>
		</a></li>
		<c:if test ="${userinfo.admin}">
		<li class="nav-item"><a class="nav-link <c:if test="${now!=7}">collapsed</c:if>"
			href="${ root }/admin/apt"> <i class="bi bi-journal-bookmark"></i> <span>APT 데이터 관리 </span>
		</a></li>
		</c:if>
		</c:if>
		
		<!-- End F.A.Q Page Nav -->

		<li class="nav-item"><a class="nav-link <c:if test="${now!=5}">collapsed</c:if>"
			href="${ root }/notice/"> <i class="bi bi-clipboard"></i> <span>공지사항</span>
		</a></li>
		<!-- End Contact Page Nav -->

	</ul>
</aside>
<!-- End Sidebar-->

<script>
	function logout() {
		sessionStorage.removeItem("user");
	}
</script>