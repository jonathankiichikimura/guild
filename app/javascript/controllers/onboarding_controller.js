import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="onboarding"
export default class extends Controller {
  static targets = ["step", "nextBtn", "backBtn", "progress"]
  static values = { current: { type: Number, default: 0 } }

  connect() {
    this.showStep(this.currentValue)
  }

  advance(event) {
    const delta = parseInt(event.params.step)
    const next = this.currentValue + delta
    if (next >= 0 && next < this.stepTargets.length) {
      this.currentValue = next
      this.showStep(this.currentValue)
    }
  }

  showStep(index) {
    this.stepTargets.forEach((step, i) => {
      step.hidden = i !== index
    })

    const isFirst = index === 0
    const isLast = index === this.stepTargets.length - 1

    this.backBtnTarget.hidden = isFirst
    this.nextBtnTarget.hidden = isLast

    if (this.hasProgressTarget) {
      this.progressTarget.textContent = `Step ${index + 1} of ${this.stepTargets.length}`
    }
  }
}
