export default InfiniteScroll = {
  // `page()` function gets the value from `data-page={@page}` attribute from `gallery_component.ex`
  page() {
    return this.el.dataset.page;
  },
  loadMore(entries) {
    const target = entries[0];
    if (target.isIntersecting && this.pending == this.page()) {
      this.pending = this.page() + 1;
      // calls `handle_event/3`
      this.pushEvent("load-more", {});
    }
  },
  mounted() {
    this.pending = this.page();
    this.observer = new IntersectionObserver(
      (entries) => this.loadMore(entries),
      {
        root: null,
        rootMargin: "400px",
        threshold: 0.1,
      }
    );
    this.observer.observe(this.el);
  },
  destroyed() {
    this.observer.unobserve(this.el);
  },
  updated() {
    this.pending = this.page();
  },
};
