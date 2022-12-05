import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";

Vue.use(Toast, {
  transition: "Vue-Toastification__bounce",
  maxToasts: 20,
  newestOnTop: true,
});
import "boxicons";
import "@/api/vueBootstrap";
//import VueConfirmDialog from "vue-confirm-dialog";

import VueSimpleAlert from "vue-simple-alert";
Vue.use(VueSimpleAlert);

//Vue.use(VueConfirmDialog);
// Vue.component("vue-confirm-dialog", VueConfirmDialog.default);

Vue.config.productionTip = false;

Vue.filter("filterPrice", (value) => {
  if (!value) return value;
  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
});

Vue.filter("filterEnterToBr", (value) => {
  if (!value) return value;
  // 문자열에 enter값을 <br />로 변경.(html상에서 줄바꿈 처리)
  return value.replace(/(?:\r\n|\r|\n)/g, "<br />");
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
