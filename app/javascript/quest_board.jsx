import React from 'react'
import QuestBoard from "./components/QuestBoard"
import { createRoot } from "react-dom/client"

const root = document.getElementById("root")
if (root) {
  createRoot(root).render(<QuestBoard />)
}
