import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "item" ]

  #cursorPosition = 0
  #selection = [ 0, 0 ]
  #moving = false

  connect() {
  }

  disconnect() {
  }

  focus() {
    this.#setSelectionState()
  }

  blur() {
    this.#clearSelectionState()
  }

  moveCursorUp(event) {
    this.#moveCursorEarlier(event.shiftKey)
  }

  moveCursorRight(event) {
    this.#moveCursorLater(event.shiftKey)
  }

  moveCursorDown(event) {
    this.#moveCursorLater(event.shiftKey)
  }

  moveCursorLeft(event) {
    this.#moveCursorEarlier(event.shiftKey)
  }

  toggleMoveMode() {
    this.element.classList.toggle("move-mode")

  }

  #moveCursorEarlier(keepSelection) {
    const index = Math.max(0, this.#cursorPosition - 1)
    this.#moveCursorTo(index, keepSelection)
  }

  #moveCursorLater(keepSelection) {
    const index = Math.min(this.itemTargets.length - 1, this.#cursorPosition + 1)
    this.#moveCursorTo(index, keepSelection)
  }

  #moveCursorTo(index, keepSelection) {
    this.#cursorPosition = index
    if (keepSelection) {
      this.#selection = [ Math.min(this.#selection[0], index), Math.max(this.#selection[1], index) ]
    } else {
      this.#selection = [ index, index ]
    }

    this.#setSelectionState()
  }

  #setSelectionState() {
    for (const [index, item] of this.itemTargets.entries()) {
      item.classList.toggle("cursor", index === this.#cursorPosition)
      item.classList.toggle("selected", this.#isSelected(index))
    }
  }

  #clearSelectionState() {
    for (const item of this.itemTargets) {
      item.classList.remove("cursor", "selected")
    }
  }

  #isSelected(index) {
    return index >= this.#selection[0] && index <= this.#selection[1]
  }
}
