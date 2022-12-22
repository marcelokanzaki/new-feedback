import { Controller } from '@hotwired/stimulus'
import { Modal } from 'bootstrap'

export default class extends Controller {
  initialize() {
    if (!window.participacaoModalInstance) {
      window.participacaoModalInstance = new Modal(this._modal)
    }

    this._instance = window.participacaoModalInstance
    this._modal.addEventListener('hide.bs.modal', this._unloadFrame, false)
  }

  connect() {
    this.element.addEventListener('click', this._show.bind(this), false)

  }

  disconnect() {
    this.element.removeEventListener('click', this._show.bind(this), false)
  }

  // PRIVATE

  _unloadFrame() {
    const frame = this.querySelector('turbo-frame')
    frame.src = null
    frame.innerHTML = ''
  }

  _show() {
    this._instance.show()
  }

  get _modal() {
    return document.getElementById('participacao-modal')
  }
}
