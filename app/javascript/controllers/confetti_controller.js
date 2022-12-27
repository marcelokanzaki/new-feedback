import { Controller } from '@hotwired/stimulus'
import confetti from 'canvas-confetti'

export default class extends Controller {
  connect() {
    const { top, height, left, width, } = this.element.getBoundingClientRect()
    const x = (left + width / 2) / window.innerWidth
    const y = (top + height / 2) / window.innerHeight
    this.origin = { x, y }
  }

  shoot(e) {
    e.preventDefault()
    confetti({
      origin: this.origin,
      particleCount: 150,
      spread: 60,
      zIndex: 1070,
    })
  }
}
