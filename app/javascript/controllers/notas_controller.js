import { Controller } from '@hotwired/stimulus'
import { useDebounce } from 'stimulus-use'

export default class extends Controller {
  static debounces = ['save']

  connect() {
    useDebounce(this, { wait: 600 })
  }

  save() {
    this.element.closest('form').querySelector('[type="submit"]').click()
  }
}
