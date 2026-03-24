// app/javascript/application.js
// Turbo, Stimulus, and Bootstrap are handled by importmap

import QuestBoard from "./components/QuestBoard"
import { createRoot } from "react-dom/client"

const root = document.getElementById("root")
if (root) {
  createRoot(root).render(<QuestBoard />)
}
