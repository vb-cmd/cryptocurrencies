import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bodyTable"]

  async initialize() {
    const response = await fetch("/api/v1/coin/coins.json")
    this.coins = await response.json()

    this.coins.forEach((coin) => {
      this.renderTr(coin)
    })
  }

  renderTr(data) {
    this.bodyTableTarget.innerHTML += `
    <tr id="row-change-${data.short_name}">
      <th scope="row">${data.rank}</th>
      <td data-controller="histories">${this.#renderWindowChart(data)}</td>
      <td>${data.full_name}</td>
      <td>${data.supply}</td>
      <td>${data.market_cap}</td>
      <td>${data.volume_24h}</td>
      <td>${data.price}</td>
      <td>${data.change_24h}</td>
    </tr>`
  }

  #renderWindowChart(data) {
    return `<button type="button" 
    class="btn btn-primary" 
    data-bs-toggle="modal" 
    data-bs-target="#static-${data.short_name}" 
    data-histories-url-param="${data.histories_url}" 
    data-action="click->histories#render">${data.symbol}</button>

    <div class="modal fade" 
    id="static-${data.short_name}" 
    data-bs-backdrop="static" 
    data-bs-keyboard="false" 
    tabindex="-1" 
    aria-labelledby="staticBackdropLabel" 
    aria-hidden="true">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">${data.full_name}</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body" data-histories-target="modalBody">
            <div class="d-flex justify-content-center" data-histories-target="spinner"></div>
            <canvas data-histories-target="chart" style="display:block;" id="chart-for-${data.short_name}"></canvas>
          </div>
        </div>
      </div>
    </div>`
  }
}