import { Controller } from 'stimulus'
import { currentUserId } from '../helpers/auth'

export default class extends Controller {
  static targets = ['actions']
  static values = {
    authorId: String,
  }

  connect() {
    if (document.querySelectorAll(`#${this.element.id}`).length > 1) {
      this.element.remove()
      return
    }

    this.element.scrollIntoView({ block: 'nearest' })
  }

  toggleActions() {
    if (this.hasActionsTarget && this.authorIdValue === currentUserId()) {
      this.actionsTarget.classList.toggle('invisible')
    }
  }
}
