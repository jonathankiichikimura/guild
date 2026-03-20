import React from "react"
import Board from "./quest_board/Board"

function QuestBoard() {
  const quests = JSON.parse(document.getElementById("root").dataset.quests)
  return (
    <Board quests={quests} />
  )
}

export default QuestBoard
