import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default DoughnutChart = {
  mounted() {
    this.DoughnutChart = new Doughnut(this.el);
  },
};

class Doughnut {
  constructor(ctx) {
    const data = {
      labels: ["Completed", "Assigned", "Due"],
      datasets: [
        {
          data: [35, 40, 25],
          backgroundColor: Object.values({
            completed: "hsl(220, 95%, 30%)",
            assigned: "hsl(220, 65%, 60%)",
            due: "hsl(220, 70%, 80%)",
          }),
        },
      ],
    };

    const config = {
      type: "doughnut",
      data: data,
      options: {
        responsive: true,
        plugins: {
          legend: {
            display: false,
          },
          title: {
            display: false,
          },
        },
      },
    };

    this.chart = new Chart(ctx, config);
  }
}
