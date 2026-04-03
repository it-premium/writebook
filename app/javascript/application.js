// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "actions"
import "controllers"
import "house"
import mermaid from "mermaid"

const MERMAID_KEYWORDS = /^(flowchart|graph|sequenceDiagram|classDiagram|stateDiagram|erDiagram|gantt|pie|gitGraph|mindmap|timeline|sankey|xychart|block)\b/

mermaid.initialize({ startOnLoad: false, theme: window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "default" })

document.addEventListener("turbo:load", () => {
  const targets = [...document.querySelectorAll("code.language-mermaid, pre.highlight.plaintext > code")]
    .filter(el => el.classList.contains("language-mermaid") || MERMAID_KEYWORDS.test(el.textContent.trim()))
  if (!targets.length) return

  targets.forEach(el => {
    const div = document.createElement("div")
    div.className = "mermaid"
    div.textContent = el.textContent
    el.closest("pre").replaceWith(div)
  })
  mermaid.run()
})

