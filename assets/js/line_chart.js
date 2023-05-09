import { Chart, registerables } from "chart.js";
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
        scales: {
          x: {
            display: false,
          },
          y: {
            display: false,
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

function triggerHover(chart, index) {
  if (chart.getActiveElements().length > 0) {
    chart.setActiveElements([]);
  } else {
    chart.setActiveElements([
      {
        datasetIndex: 0,
        index: index,
      },
    ]);
  }
  chart.update();
}
