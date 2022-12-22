import { Controller } from "@hotwired/stimulus"
import ConfettiGenerator from "confetti-js"

export default class extends Controller {
  connect() {
    var confettiSettings = { target: 'confetti-canvas' };
    var confetti = new ConfettiGenerator(confettiSettings);
    confetti.render();
  }
}
