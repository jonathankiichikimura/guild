import React from 'react'
import Flyer from "./Flyer"

function Board({ quests }) {
  return (
    quests.map((quest) => (
      <Flyer key={quest.id} quest={quest} />
    ))
  )
}

export default Board
