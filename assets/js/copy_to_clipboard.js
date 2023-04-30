export default CopyToClipboard = {
  mounted() {
    let { to } = this.el.dataset;
    this.el.addEventListener("click", (event) => {
      event.preventDefault();
      let text = document.querySelector(to).value;
      navigator.clipboard.writeText(text).then(() => {
        console.log("All done again!");
      });
    });
  },
};
