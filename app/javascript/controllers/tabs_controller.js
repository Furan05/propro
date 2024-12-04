import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "pane"]

  connect() {
    console.log("Tabs controller connected") // Debug
    this.showTab(0) // Show first tab by default
  }

  switch(event) {
    const button = event.currentTarget
    const index = this.tabTargets.indexOf(button)
    this.showTab(index)
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      tab.classList.toggle("active", i === index)
      this.paneTargets[i].classList.toggle("active", i === index)
    })
  }
}
