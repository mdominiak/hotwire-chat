import { Controller } from 'stimulus'

export default class extends Controller {
  connect() {
    if (document.querySelectorAll(`#${this.element.id}`).length > 1) {
      this.element.remove()
      return
    }

    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.parentNode.scrollTop = this.element.parentNode.scrollHeight
  }
}
