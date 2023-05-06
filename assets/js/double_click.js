export default DoubleClick = {
  mounted() {
    const id = parseInt(this.el.dataset.item_id);
    const phx_event = this.el.dataset.phx_event;
    window.addEventListener("dblclick", (e) => {
      this.pushEventTo(this.el, phx_event, { id: id });
    });
  },
  updated() {
    const id = parseInt(this.el.dataset.item_id);
    const phx_event = this.el.dataset.phx_event;
    window.addEventListener("dblclick", (e) => {
      this.pushEventTo(this.el, phx_event, { id: id });
    });
  },
};
