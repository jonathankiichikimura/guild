import React from 'react'
import Flyer from "./Flyer"

function Board({ quests }) {
  return (
    <div className="board-frame">
      <div className="title-sign"></div>
      <div className="board-frame__corner board-frame__corner--tl"></div>
      <div className="board-frame__corner board-frame__corner--tr"></div>
      <div className="board-frame__corner board-frame__corner--bl"></div>
      <div className="board-frame__corner board-frame__corner--br"></div>
      <div className="cork-board">
        {quests.map((quest, index) => <Flyer key={quest.id} quest={quest} index={index} />)}
      </div>
    </div>
  )
}

export default Board
