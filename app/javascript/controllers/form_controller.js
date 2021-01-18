import { Controller } from 'stimulus'

const ERROR_BLANK = "Can't be blank"

const validatePresence = (input) => {
  if (input.hasAttribute('required')) {
    if (input.value.trim() === '') {
      input.setCustomValidity(ERROR_BLANK)
      return false
    } else {
      if (input.validity.customError) input.setCustomValidity('')
      return true
    }
  } else {
    return true
  }
}

export default class extends Controller {
  connect() {
    this.element.querySelectorAll('input[required]').forEach((input) => {
      input.addEventListener('input', this.validateInput)
    })
  }

  disconnect() {
    this.element.querySelectorAll('input[required]').forEach((input) => {
      input.removeEventListener('input', this.validateInput)
    })
  }

  validateInput() {
    validatePresence(this) // && validateSomethingElse()
  }

  resetForm() {
    this.element.reset()
  }
}
