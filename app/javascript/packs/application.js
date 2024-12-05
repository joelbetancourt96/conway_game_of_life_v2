import Vue from "vue";
import Matrix from "../components/Matrix.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: "#app",
    components: { Matrix },
  });
});
