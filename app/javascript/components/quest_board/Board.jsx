import React from 'react'
import Flyer from "./Flyer"

function Board({ quests }) {
  return (
    <div className="board-frame">
      <div className="title-sign"></div>
      <div className="cork-board">
        {quests.map((quest) => <Flyer key={quest.id} quest={quest} />)}
      </div>
    </div>
  )
}

export default Board
