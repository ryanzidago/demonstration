import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

export default DoughnutChart = {
  mounted() {
    this.DoughnutChart = new Doughnut(this.el);

    // trigger data hover on legend item hover
    const legend = document.getElementById("doughnut-chart-legend");
    for (let i = 1; i < legend.children.length; i++) {
      legend.children[i].addEventListener("mouseover", (e) => {
        triggerHover(this.DoughnutChart.chart, i - 1);
      });

      legend.children[i].addEventListener("mouseout", (e) => {
        triggerHover(this.DoughnutChart.chart, i - 1);
      });
    }
  },
};

class Doughnut {
  constructor(ctx) {
    const data = {
      labels: ["Completed", "Assigned", "Due"],
      datasets: [
        {
          data: [35, 40, 25],
          hoverBorderWidth: 2,
          hoverBorderColor: "hsl(220, 95%, 30%)",
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
