import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['actions']

  connect() {
    if (document.querySelectorAll(`#${this.element.id}`).length > 1) {
      this.element.remove()
      return
    }

    this.element.scrollIntoView({ block: 'nearest' })
  }

  toggleActions() {
    if (this.hasActionsTarget) {
      this.actionsTarget.classList.toggle('invisible')
    }
  }
}
