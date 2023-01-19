import '@hotwired/turbo-rails'
import 'bootstrap'
import 'trix'
import '@rails/actiontext'
import './controllers'

Turbo.StreamActions.show = function() {
  document.getElementById(this.target)?.classList.remove('d-none')
}

Turbo.StreamActions.hide = function() {
  document.getElementById(this.target)?.classList.add('d-none')
}
