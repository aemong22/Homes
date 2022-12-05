import { apiInstance } from "./index.js";

const api = apiInstance();

async function login(user, success, fail) {
  console.log(user);
  await api.post(`/user/login`, JSON.stringify(user)).then(success).catch(fail);
}

async function findById(userId, success, fail) {
  api.defaults.headers["access-token"] = sessionStorage.getItem("access-token");
  await api.get(`/user/info/${userId}`).then(success).catch(fail);
}

async function checkId(id, success, fail) {
  await api.get(`/user/checkId/${id}`).then(success).catch(fail);
}

async function getUsers(success, fail) {
  await api.get(`/admin/user`).then(success).catch(fail);
}

async function joinUser(user, success, fail) {
  await api.post(`/user/join`, JSON.stringify(user)).then(success).catch(fail);
}

async function delUser(userId, success, fail) {
  await api.delete(`/user/delete/${userId}`).then(success).catch(fail);
}

async function adminDelUser(userId, success, fail) {
  await api.delete(`/admin/delete/${userId}`).then(success).catch(fail);
}

async function editUser(user, success, fail) {
  await api
    .put(`/user/mypage/edit`, JSON.stringify(user))
    .then(success)
    .catch(fail);
}

async function tokenRegeneration(user, success, fail) {
  api.defaults.headers["refresh-token"] =
    sessionStorage.getItem("refresh-token"); //axios header에 refresh-token 셋팅
  await api.post(`/user/refresh`, user).then(success).catch(fail);
}

async function logout(userId, success, fail) {
  await api.get(`/user/logout/${userId}`).then(success).catch(fail);
}

async function sendEmail(sendEmail, success, fail) {
  console.log(sendEmail);
  await api.post(`/user/sendpw/${sendEmail}`).then(success).catch(fail);
}

async function getCountC(userId, success, fail) {
  await api.get(`/concern/count/${userId}`).then(success).catch(fail);
}

async function getCountQ(userId, success, fail) {
  await api.get(`/qna/count/${userId}`).then(success).catch(fail);
}

export {
  login,
  findById,
  tokenRegeneration,
  logout,
  checkId,
  joinUser,
  editUser,
  delUser,
  getUsers,
  adminDelUser,
  sendEmail,
  getCountC,
  getCountQ,
};
