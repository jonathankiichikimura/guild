import React from 'react'

function Flyer({ quest }) {
  return (
    <div className="flyer">
      <div className="flyer__pin"></div>
      <div className="flyer__paper">
        <h3>{quest.title}</h3>
        <span>{quest.description}</span>
        <span>{quest.reward_amount}{quest.reward_type}</span>
      </div>
    </div>
  )
}

export default Flyer
