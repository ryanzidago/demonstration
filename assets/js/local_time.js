export default LocalTime = {
  mounted() {
    let dt = new Date(this.el.textContent.trim());
    this.el.textContent =
      dt.toLocaleString() +
      " " +
      Intl.DateTimeFormat().resolvedOptions().timeZone;
    this.el.classList.remove("invisible");
  },
  updated() {
    let dt = new Date(this.el.textContent.trim());
    this.el.textContent =
      dt.toLocaleString() +
      " " +
      Intl.DateTimeFormat().resolvedOptions().timeZone;
    this.el.classList.remove("invisible");
  },
};
