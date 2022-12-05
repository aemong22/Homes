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
		<div class="container-fluid">

			<div class="pagetitle row justify-content-center">
				<h1>회원 정보 관리</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">관리자 모드</li>
						<li class="breadcrumb-item active">회원 정보 관리</li>
					</ol>
				</nav>
			</div>
			<!-- End Page Title -->

			<div class="row justify-content-center">
				<div class="col">

					<div class="card overflow-auto">
						<div class="card-body">
							<h5 class="card-title">회원 정보</h5>

							<!-- Default Accordion -->
							<table class="table">
								<thead>
									<tr>
										<th scope="col">ID</th>
										<th scope="col">NAME</th>
										<th scope="col">PWD</th>
										<th scope="col">PHONE</th>
										<th scope="col">EMAIL</th>
										<th scope="col">ADDRESS</th>
										<th scope="col">ADMIN</th>
										<th scope="col">EDIT</th>
									</tr>
								</thead>
								<tbody id="userlist"></tbody>
							</table>
							<button type="button"
								class="btn btn-warning rounded-pill btn-block"
								onclick="location.href='${root}/admin/addUser'">회원 추가</button>
							<input type="text" id="search_user" value=""
								placeholder="아이디를 입력해주세요." />
							<button class="btn btn-outline-primary" onclick="search_user()"
								type="button">검색</button>


						</div>
						<!-- End Default Accordion Example -->

					</div>
				</div>

			</div>
		</div>
		</div>
	</main>
	<!-- End #main -->
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="../common/footer.jsp"%>

</body>
<script>
// 회원 목록
fetch(`${root}/admin/user`)
  .then(response => response.json())
  .then(data => makeList(data));
  
  
function makeList(users) {
	console.log(users);
    let tbody = ``;
    users.forEach(function (user) {
    	console.log(user.userId);
      tbody += `
					<tr id="view_\${user.userId}" class="view text-center" data-id="\${user.userId}">
						<td>\${user.userId}</td>
						<td>\${user.userName}</td>
						<td>\${user.userPwd}</td>
						<td>\${user.phonenumber}</td>
						<td>\${user.emailId} @ \${user.emailDomain}</td>
						<td>\${user.address}</td>
						<td>\${user.admin}</td>
						<td>
							<button type="button" class="modifyViewBtn btn btn-outline-primary btn-sm" onclick="viewModify(this)">수정</button>
							<button type="button" class="deleteBtn btn btn-outline-danger btn-sm" onclick="deleteUser(this)">삭제</button>
						</td>
					</tr>
					<tr id="mview_\${user.userId}" data-id="\${user.userId}" style="display: none;" class="text-center">
						<td>\${user.userId}</td>
          <td><input type="text" name="username" id="username\${user.userId}" value="\${user.userName}"></td>
						<td><input type="text" name="userpass" id="userpass\${user.userId}" value="\${user.userPwd}"></td>
						<td><input type="text" id="userphone\${user.userId}" value="\${user.phonenumber}"></td>
          <td><input type="text" id="emailid\${user.userId}"
				value = "\${user.emailId}" required />@<select
					class="form-select" id="emaildomain\${user.userId}" name="emaildomain"
					aria-label="이메일 도메인 선택" required>
					<option value="">선택</option>
					<option value="ssafy.com">ssafy.com</option>
					<option value="google.com">google.com</option>
					<option value="naver.com">naver.com</option>
					<option value="kakao.com">kakao.com</option>
				</select></td>
				<td><input type="text" id="useraddress\${user.userId}" value="\${user.address}"></td>
				<td><input type="text" id="useradmin\${user.userId}" value="\${user.admin}" disabled = true></td>
						<td>
							<button type="button" class="modifyBtn btn btn-primary btn-sm" onclick="userModify(this)">수정</button>
							<button type="button" class="cancelBtn btn btn-danger btn-sm" onclick="closeModify(this)">취소</button>
						</td>
					</tr>
				`;
    });
    document.querySelector("#userlist").innerHTML = tbody;
  }
  
	// 관리자 : 수정 페이지 보기
	function viewModify(el) {
	  let id = el.parentNode.parentNode.getAttribute("data-id");
	  document.querySelector(`#view_\${id}`).setAttribute("style", "display: none;");
	  document.querySelector(`#mview_\${id}`).setAttribute("style", "display: ;");
	}
	
	// 관리자 : 수정 페이지 닫기
	function closeModify(el) {
	  let id = el.parentNode.parentNode.getAttribute("data-id");
	  document.querySelector(`#view_\${id}`).setAttribute("style", "display: ;");
	  document.querySelector(`#mview_\${id}`).setAttribute("style", "display: none;");
	}
	
	// 관리자 : 회원 정보 수정
	function userModify(el) {
		 
	  let id = el.parentNode.parentNode.getAttribute("data-id");
  	  let editInfo = {
    			userId: el.parentNode.parentNode.getAttribute("data-id"),
    			userPwd: document.querySelector(`#userpass\${id}`).value,
    			userName: document.querySelector(`#username\${id}`).value,
    			emailId: document.querySelector(`#emailid\${id}`).value,
    			emailDomain: document.querySelector(`#emaildomain\${id}`).value,
    			address: document.querySelector(`#useraddress\${id}`).value,
    			phonenumber: document.querySelector(`#userphone\${id}`).value,
    	  };
	  let config = {
	    method: "PUT",
	    headers: {
	      "Content-Type": "application/json"
	    },
	    body: JSON.stringify(editInfo),
	  };
	  fetch(`${root}/admin/edit`, config)
	    .then(response => response.json())
	    .then(data => makeList(data));
	}
	
	// 관리자 : 회원 정보 삭제
	function deleteUser(el) {
	  let id = el.parentNode.parentNode.getAttribute("data-id");
	  let config = {
	    method: "DELETE",
	    headers: {
	      "Content-Type": "application/json"
	    }
	  };
	  fetch(`${root}/admin/remove/\${id}`, config)
	    .then(response => response.json())
	    .then(data => makeList(data));
	}
	
	// 관리자 : 회원 검색
	function search_user() {
		let id = document.querySelector('#search_user').value;
		  fetch(`${root}/admin/search/\${id}`)
		    .then(response => response.json())
		    .then(data => makeList(data));
		
	}

</script>

</html>