import { Controller } from '@hotwired/stimulus'
import Choices from 'choices.js'

export default class extends Controller {
  connect() {
    this.instance = new Choices(this.element)
  }
}
