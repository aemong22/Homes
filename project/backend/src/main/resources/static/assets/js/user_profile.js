//window.onload = function () {
//  let user_id = document.querySelectorAll(".user-id");
//  let user_pw = document.querySelectorAll(".user-pw");
//  let user_name = document.querySelectorAll(".user-name");
//  let user_addr = document.querySelectorAll(".user-addr");
//  let user_phone = document.querySelectorAll(".user-phone");
//
//  let user = JSON.parse(localStorage.getItem("user"));
//
//  if (user) {
//    user_id.forEach((id) => (id.innerText = user.id));
//    user_pw.forEach((pw) => (pw.innerText = user.password));
//    user_name.forEach((name) => (name.innerText = user.name));
//    user_addr.forEach((addr) => (addr.innerText = user.address));
//    user_phone.forEach((phone) => (phone.innerText = user.phone));
//
//    document.querySelector("#user-id").value = user.id;
//    document.querySelector("#user-pw").value = user.password;
//    document.querySelector("#user-name").value = user.name;
//    document.querySelector("#user-addr").value = user.address;
//    document.querySelector("#user-phone").value = user.phone;
//  } else {
//    location.href = "./index.html";
//  }
//};
//
//function resign() {
//  localStorage.removeItem("user");
//  alert("탈퇴 완료!");
//  location.href = "./index.html";
//}
