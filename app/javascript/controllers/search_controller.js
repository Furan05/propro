import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "suggestions"]
  static values = { url: String }

  connect() {
    console.log("Search controller connected")
  }

  suggest(event) {
    event.preventDefault() // Empêcher la soumission du formulaire
    const query = this.inputTarget.value

    if (query.length < 1) {
      this.suggestionsTarget.style.display = "none"
      return
    }

    fetch(`${this.urlValue}?query=${query}`, {
      headers: {
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      console.log("Received data:", data)
      this.suggestionsTarget.innerHTML = data
        .map(item => `
          <a href="/daddy_services/${item.id}" class="suggestion">
            ${item.title} (${item.category})
          </a>
        `).join('')
      this.suggestionsTarget.style.display = "block"
    })
  }
}
