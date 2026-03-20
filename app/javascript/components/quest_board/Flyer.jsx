import React from 'react'

function Flyer({ quest }) {
  return (
    <div>
      <h3>{quest.title}</h3>
      <span>{quest.description}</span>
      <span>{quest.reward_amount}{quest.reward_type}</span>
    </div>
  )
}

export default Flyer
