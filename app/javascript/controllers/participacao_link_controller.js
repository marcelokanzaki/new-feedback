import { Controller } from '@hotwired/stimulus'
import { Modal } from 'bootstrap'



export default class extends Controller {
  connect() {
    if (!window.participacaoModalInstance) {
      this._setupModal()
    }
  }

  disconnect() {
    if (window.participacaoModalInstance) {
      delete window.participacaoModalInstance
    }
  }

  showModal() {
    console.log(window.participacaoModalInstance)
    window.participacaoModalInstance.show()
  }

  // PRIVATE

  _setupModal() {
    const modalEl = document.getElementById('participacao-modal')
    window.participacaoModalInstance = new Modal(modalEl)

    modalEl.addEventListener('hide.bs.modal', () => {
      console.log('closing modal')
      const frame = modalEl.querySelector('turbo-frame')
      frame.src = null
      frame.innerHTML = ''
    })
  }
}
