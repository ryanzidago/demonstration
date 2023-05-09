import { Chart, LogarithmicScale, registerables } from "chart.js";
Chart.register(...registerables);

export default LineChart = {
  mounted() {
    this.LineChart = new Line(this.el);
  },
};

class Line {
  constructor(ctx) {
    const datasetData = [
      0, 15, -30, 10, -20, 0, 45, -1, 40, -5, -5, -8, 10, 1.4,
    ];

    const data = {
      labels: datasetData,
      datasets: [
        {
          data: datasetData,
          // https://www.chartjs.org/docs/latest/configuration/elements.html
          pointStyle: false,
          borderWidth: 2,
          borderColor: "hsl(220,65%,60%)",
        },
      ],
    };

    const config = {
      type: "line",
      data: data,
      options: {
        aspectRatio: 8,
        scales: {
          x: {
            display: false,
          },
          y: {
            ticks: {
              display: false,
            },
            display: true,
          },
        },
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
