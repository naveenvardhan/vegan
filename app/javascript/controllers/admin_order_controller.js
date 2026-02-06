import NestedFormController from "./nested_form_controller"

export default class extends NestedFormController {
  static values = { prices: Object }

  // This method is specific to the Admin Order portal
  updatePrice(event) {
    const itemId = event.target.value
    const row = event.target.closest('tr')
    const priceInput = row.querySelector("input[name*='price_at_order']")
    
    // The prices are passed via data-admin-order-prices-value
    const price = this.pricesValue[itemId]
    
    if (price) {
      priceInput.value = price
    } else {
      priceInput.value = ""
    }
  }
}