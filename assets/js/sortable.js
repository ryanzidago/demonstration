import sortable from "../vendor/sortable";

export default Sortable = {
  mounted() {
    new sortable(this.el, {
      animation: 150,
      delay: 100,
      dragClass: this.el.dataset["drag_class"],
      ghostClass: this.el.dataset["ghost_class"],
      forceFallback: true,
      onEnd: (e) => {
        let params = {
          from: e.oldIndex,
          to: e.newIndex,
          ...e.item.dataset,
        };
        this.pushEventTo(this.el, "reposition", params);
      },
    });
  },
};
