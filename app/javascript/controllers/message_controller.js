import { Controller } from 'stimulus'

export default class extends Controller {
  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.parentNode.scrollTop = this.element.parentNode.scrollHeight
  }
}
