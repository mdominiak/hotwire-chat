import { Controller } from 'stimulus'

export default class extends Controller {
  connect() {
    if (document.querySelectorAll(`#${this.element.id}`).length > 1) {
      this.element.remove()
      return
    }

    this.dispatchMessageAdded()
  }

  dispatchMessageAdded() {
    const event = new CustomEvent('message:added', { bubbles: true })
    this.element.dispatchEvent(event)
  }
}
