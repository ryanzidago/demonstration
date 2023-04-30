export default InfiniteScroll = {
  // page(): Returns the current page of the component that the hook is attached to.
  // This is set as a custom attribute in the DOM element of the component.
  page() {
    return this.el.dataset.page;
  },
  // loadMore(entries): This method gets called whenever an observed element intersects the viewport.
  // It checks whether the pending page number is equal to the current page number
  // before calling a LiveView event to load more data.
  // This is done to prevent unnecessary requests being made if the same page number is loaded multiple times.
  loadMore(entries) {
    const target = entries[0];
    if (target.isIntersecting && this.pending == this.page()) {
      this.pending = this.page() + 1;
      // calls `handle_event/3`
      this.pushEvent("load-more", {});
    }
  },
  // mounted(): This method is called when the component is inserted into the DOM.
  // It initializes the Intersection Observer with a root margin of 400 pixels and a threshold of 0.1.
  // It then observes the component element and calls the loadMore method whenever it intersects the viewport.
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
  // destroyed(): This method is called when the component is removed from the DOM.
  // It stops the Intersection Observer from observing the component element.
  destroyed() {
    this.observer.unobserve(this.el);
  },
  // updated(): This method is called when the component is updated.
  // It sets the pending page number to the current page number
  // so that loadMore will only be called once per page.
  updated() {
    this.pending = this.page();
  },
};
