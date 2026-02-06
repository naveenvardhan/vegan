import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["template", "container"]
  static values = { prices: Object }

  add(event) {
    event.preventDefault()
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.containerTarget.insertAdjacentHTML('beforeend', content)
  }

  remove(event) {
    event.preventDefault()
    const wrapper = event.target.closest('tr')
    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove()
    } else {
      wrapper.style.display = 'none'
      wrapper.querySelector("input[name*='_destroy']").value = '1'
    }
  }

  // New method to handle price population
  updatePrice(event) {
    const itemId = event.target.value
    const row = event.target.closest('tr')
    const priceInput = row.querySelector("input[name*='price_at_order']")
    
    // Get price from the values passed to the controller
    const price = this.pricesValue[itemId]
    
    if (price) {
      priceInput.value = price
    } else {
      priceInput.value = ""
    }
  }
}