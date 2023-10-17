import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static outlets = ["coins"]
    static targets = ["queryInput"]

    findCoins() {
        const coinsClass = this.coinsOutlet

        coinsClass.bodyTableTarget.innerHTML = ""

        coinsClass.coins.forEach((coin) => {
            if (coin.full_name.toLowerCase().includes(this.queryInputTarget.value.toLowerCase())) {
                coinsClass.renderTr(coin)
            }
        })
    }
}