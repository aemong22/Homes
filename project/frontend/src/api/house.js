import { apiInstance, kakaoInstance } from "./index.js";

const api = apiInstance();
// const house = houseInstance();
const kakao = kakaoInstance();

function sidoList(success, fail) {
  api.get(`/rest/house/sido`).then(success).catch(fail);
}

function gugunList(params, success, fail) {
  api.get(`/rest/house/gugun`, { params: params }).then(success).catch(fail);
}

function dongList(params, success, fail) {
  api.get(`/rest/house/dong`, { params: params }).then(success).catch(fail);
}

function houseList(params, success, fail) {
  api.get(`/houseInfo`, { params: params }).then(success).catch(fail);
}

function multihouseList(params, success, fail) {
  //house.get(``, { params: params }).then(success).catch(fail);
  api.get(`/houseInfo/jutaek`, { params: params }).then(success).catch(fail);
}

function searchCategoryList(params, success, fail) {
  kakao
    .get(`/search/category.json`, { params: params })
    .then(success)
    .catch(fail);
}

function coord2Regioncode(params, success, fail) {
  kakao
    .get(`/geo/coord2regioncode.json`, { params: params })
    .then(success)
    .catch(fail);
}

function searchAddress(params, success, fail) {
  kakao
    .get(`/search/address.json`, { params: params })
    .then(success)
    .catch(fail);
}
// 관심지역 확인
async function ckConcern(userId, dongCode, success, fail) {
  await api
    .get(`/concern/ckConcern/${userId}/${dongCode}`)
    .then(success)
    .catch(fail);
}

// 관심지역 등록
async function registerConcern(payload, success, fail) {
  await api.post(`/concern`, payload).then(success).catch(fail);
}

// 관심지역 삭제
async function deleteConcern(userId, dongCode, success, fail) {
  await api.delete(`/concern/${userId}/${dongCode}`).then(success).catch(fail);
}

// 관심지역 목록 get
async function getConcernList(userId, success, fail) {
  console.log(userId);
  await api.get(`/concern/${userId}`).then(success).catch(fail);
}

// 아파트 매매 역사 get
async function getAptDealHistroy(aptCode, success, fail) {
  await api
    .get(`/houseInfo/aptdealhistory/${aptCode}`)
    .then(success)
    .catch(fail);
}

// 아파트 년도 별 평균
async function getAptDealyear(success, fail) {
  await api.get(`/houseInfo/aptdealYear`).then(success).catch(fail);
}

// 관심지역 년도 별 평균
async function getAptDealyearConcern(payload, success, fail) {
  await api.post(`/houseInfo/aptdealYear`, payload).then(success).catch(fail);
}

export {
  sidoList,
  gugunList,
  dongList,
  multihouseList,
  houseList,
  searchCategoryList,
  coord2Regioncode,
  ckConcern,
  registerConcern,
  deleteConcern,
  getConcernList,
  getAptDealHistroy,
  searchAddress,
  getAptDealyear,
  getAptDealyearConcern,
};
