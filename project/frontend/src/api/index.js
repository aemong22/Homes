import axios from "axios";

// local vue api axios instance
function apiInstance() {
  const instance = axios.create({
    baseURL: "http://localhost:9999/",
    //baseURL: process.env.VUE_APP_API_BASE_URL,
    headers: {
      "Content-Type": "application/json;",
    },
  });
  return instance;
}

// house deal API axios instance
function houseInstance() {
  const instance = axios.create({
    baseURL: process.env.VUE_APP_HOUSE_DEAL_URL,
    headers: {
      "Content-Type": "application/json;charset=utf-8",
    },
  });
  return instance;
}

// kakao API axios instance
function kakaoInstance() {
  const instance = axios.create({
    baseURL: process.env.VUE_APP_KAKAO_URL,
    headers: {
      "Content-Type": "application/json;charset=utf-8",
      Authorization: process.env.VUE_APP_KAKAO_AUTH_REST_KEY,
    },
  });
  return instance;
}
export { apiInstance, houseInstance, kakaoInstance };
