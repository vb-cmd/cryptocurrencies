import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switch-theme"
export default class extends Controller {
  static targets = ["nameLabel", "checkBox"]

  initialize() {
    // Set default theme
    let themeName = localStorage.getItem("theme") || "light"
    this.#setTheme(themeName)
  }

  triger() {
    switch (localStorage.getItem("theme")) {
      case "light":
        this.#setTheme("dark")
        break;
      case "dark":
        this.#setTheme("light")
        break;
    }
  }

  #setTheme(name) {
    localStorage.setItem("theme", name)
    
    this.nameLabelTarget.textContent = `${name[0].toUpperCase()}${name.slice(1)}`
    this.checkBoxTarget.checked = name == "light"

    document.body.setAttribute("data-bs-theme", name)
  }
}
