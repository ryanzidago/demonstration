export default DoubleClick = {
  mounted() {
    window.addEventListener("dblclick", (e) => {
      const id = parseInt(e.target.dataset["double_click_item_id"]);
      if (id) {
        this.pushEventTo(this.el, "double_click", { id: id });
      }
    });
  },
};
