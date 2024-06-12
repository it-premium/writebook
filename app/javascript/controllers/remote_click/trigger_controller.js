import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static outlets = ["remote-click"]

  click() {
    this.remoteClickOutlet.click()
  }
}
