import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="histories"
export default class extends Controller {
  static targets = ["spinner", "chart", "modalBody"]

  async render(event) {
    if (this.chart) {
      this.chart.destroy();
    }

    this.spinnerTarget.innerHTML = this.#renderSpinner();

    const response = await fetch(event.params.url)
    const data = await response.json();

    this.spinnerTarget.innerHTML = "";

    this.chart = new Chart(
      this.chartTarget.id,
      this.#generateConfig(data)
    );
  }

  #renderSpinner() {
    return `<div class="spinner-border" role="status">
              <span class="visually-hidden">Loading...</span>
            </div>`
  }

  #generateConfig(data) {
    return {
      type: 'line',
      data: {
        labels: data.map((row) => new Date(row.date).toDateString()),
        datasets: [
          {
            label: 'Price',
            data: data.map((row) => row.price),
            backgroundColor: '#0b5ed7',
          }
        ]
      }
    }
  }
}
