import React from 'react'
import Flyer from "./Flyer"
import { useState } from "react"

function Board({ quests }) {
  const [stack, setStack] = useState([])

  const bringToFront = (index) => {
    setStack(prev => [...prev.filter(i => i !== index), index])
  }

  const slots = [
    { x: 2,  y: 3,  rotation: -3.5 },
    { x: 20, y: 5,  rotation: 2 },
    { x: 40, y: 2,  rotation: -1.5 },
    { x: 58, y: 6,  rotation: 3 },
    { x: 76, y: 3,  rotation: -2 },
    { x: 8,  y: 38, rotation: 1.5 },
    { x: 26, y: 42, rotation: -3 },
    { x: 48, y: 36, rotation: 2.5 },
    { x: 66, y: 40, rotation: -1 },
    { x: 80, y: 38, rotation: 3.5 },
    { x: 14, y: 62, rotation: -2.5 },
    { x: 52, y: 65, rotation: 1 },
  ]

  return (
    <div className="board-frame">
      <div className="title-sign"></div>
      <div className="board-frame__corner board-frame__corner--tl"></div>
      <div className="board-frame__corner board-frame__corner--tr"></div>
      <div className="board-frame__corner board-frame__corner--bl"></div>
      <div className="board-frame__corner board-frame__corner--br"></div>
      <div className="cork-board">
        {quests.map((quest, index) => (
          <Flyer
            key={quest.id}
            quest={quest}
            index={index}
            slot={slots[index]}
            onMouseEnter={() => bringToFront(index)}
            stack={stack}
          />
        ))}
      </div>
    </div>
  )
}

export default Board
