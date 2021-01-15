import { Controller } from 'stimulus'

export default class extends Controller {
  resetForm() {
    this.element.reset()
  }
}
