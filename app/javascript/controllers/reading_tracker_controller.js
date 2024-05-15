import { Controller } from "@hotwired/stimulus"
import { setCookie } from "helpers/cookie_helpers"

export default class extends Controller {
  static values = { bookId: Number, leafId: Number }

  connect() {
    this.#storeProgress()
  }

  #storeProgress() {
    setCookie(`reading_progress_${this.bookIdValue}`, this.leafIdValue)
  }
}
