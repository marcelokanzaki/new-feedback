import { Controller } from '@hotwired/stimulus'
import confetti from 'canvas-confetti'

export default class extends Controller {
  initialize() {
    const { top, height, left, width, } = this.element.getBoundingClientRect()
    const x = (left + width / 2) / window.innerWidth
    const y = (top + height / 2) / window.innerHeight
    const origin = { x, y }

    confetti({
      origin,
      particleCount: 150,
      spread: 60,
      zIndex: 1070,
    })
  }
}
