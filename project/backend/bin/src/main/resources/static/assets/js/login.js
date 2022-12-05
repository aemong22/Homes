//window.onload = function () {
//  let names = document.querySelectorAll(".user-id");
//  let user = JSON.parse(localStorage.getItem("user"));
//
//  if (window.location.pathname == "/index.html") {
//    if (user) {
//      location.href = "./index_user.html";
//    }
//  } else {
//    if (user) {
//      for (var i = 0; i < names.length; i++) {
//        names[i].innerHTML = user.id;
//      }
//    } else if (window.location.pathname == "/index_user.html") {
//      location.href = "./index.html";
//    }
//  }
//};
//
//function login() {
//  let id = document.querySelector("#yourId").value;
//  let pw = document.querySelector("#yourPassword").value;
//  console.log(id + " " + pw);
//  if (id == "ssafy" && pw == "1234") {
//    alert("Login Success!");
//    var user = {
//      id: id,
//      password: pw,
//      name: "김싸피",
//      address: "서울시 강남구 테헤란로 멀티스퀘어",
//      phone: "010-1234-5678",
//    };
//    localStorage.setItem("user", JSON.stringify(user));
//    location.href = "./index_user.html";
//  } else {
//    alert("잘못된 아이디 또는 비밀번호를 입력했습니다.");
//  }
//}
//
//function logout() {
//  var answer = window.confirm("Are you sure you want to log out?");
//  if (answer) {
//    localStorage.removeItem("user");
//    alert("로그아웃 되었습니다.");
//    location.href = "./index.html";
//  } else return false;
//}
