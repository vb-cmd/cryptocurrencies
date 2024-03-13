class APIService {
    static SERVER_URL = "http://127.0.0.1:3001"
    static API_V1 = "/api/v1"

    static async getCoinHistories(coinShortName, start_date, end_date) {
        let url = this.#buildUrl(`${this.API_V1}/coin/coins/${coinShortName}/histories.json`, { start: start_date, end: end_date });

        return await this.#getJson(url)
    }

    static async getCoins(page = 1, perPage = 50) {
        let url = this.#buildUrl(`${this.API_V1}/coin/coins.json`, { page: page, per_page: perPage });

        return await this.#getJson(url)
    }

    static #buildUrl(path, params = {}) {
        let url = new URL(path, this.SERVER_URL)

        for (const [key, value] of Object.entries(params)) {
            url.searchParams.set(key, value)
        }

        return url;
    }

    static async #getJson(url) {
        const data = await fetch(url.href, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        
        return await data.json()
    }
}


export default APIService;