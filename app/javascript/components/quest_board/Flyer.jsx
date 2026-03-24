import React from 'react'
import { motion } from "framer-motion"

function Flyer({ quest, index, slot, onMouseEnter, stack, onClick, zoom }) {
  const burnVariant = index % 4
  const showBurn = index % 8 < 4
  const burns = [
    // variant 0 — burn bottom-left
    <svg key={0} style={{position:'absolute', bottom:0, left:0, width:'80px', height:'68px', overflow:'visible', pointerEvents:'none', zIndex:3}} viewBox="0 0 80 68">
      <defs>
        <radialGradient id={`burn-${quest.id}`} cx="0%" cy="100%" r="100%">
          <stop offset="0%" stopColor="#0e0602" stopOpacity="1"/>
          <stop offset="45%" stopColor="#3a1c08" stopOpacity="0.92"/>
          <stop offset="88%" stopColor="#a06828" stopOpacity="0.35"/>
          <stop offset="100%" stopColor="#c08840" stopOpacity="0"/>
        </radialGradient>
      </defs>
      <ellipse cx="0" cy="68" rx="76" ry="62" fill={`url(#burn-${quest.id})`}/>
    </svg>,

    // variant 1 — burn top-right
    <svg key={1} style={{position:'absolute', top:0, right:0, width:'72px', height:'62px', overflow:'visible', pointerEvents:'none', zIndex:3}} viewBox="0 0 72 62">
      <defs>
        <radialGradient id={`burn-${quest.id}`} cx="100%" cy="0%" r="100%">
          <stop offset="0%" stopColor="#0c0501" stopOpacity="1"/>
          <stop offset="42%" stopColor="#381806" stopOpacity="0.92"/>
          <stop offset="84%" stopColor="#9c5c22" stopOpacity="0.35"/>
          <stop offset="100%" stopColor="#be7c38" stopOpacity="0"/>
        </radialGradient>
      </defs>
      <ellipse cx="72" cy="0" rx="68" ry="58" fill={`url(#burn-${quest.id})`}/>
    </svg>,

    // variant 2 — burn bottom-right
    <svg key={2} style={{position:'absolute', bottom:0, right:0, width:'75px', height:'65px', overflow:'visible', pointerEvents:'none', zIndex:3}} viewBox="0 0 75 65">
      <defs>
        <radialGradient id={`burn-${quest.id}`} cx="100%" cy="100%" r="100%">
          <stop offset="0%" stopColor="#0c0501" stopOpacity="1"/>
          <stop offset="40%" stopColor="#3c1c08" stopOpacity="0.92"/>
          <stop offset="80%" stopColor="#a06028" stopOpacity="0.35"/>
          <stop offset="100%" stopColor="#c08038" stopOpacity="0"/>
        </radialGradient>
      </defs>
      <ellipse cx="75" cy="65" rx="72" ry="62" fill={`url(#burn-${quest.id})`}/>
    </svg>,

    // variant 3 — burn top-left
    <svg key={3} style={{position:'absolute', top:0, left:0, width:'60px', height:'55px', overflow:'visible', pointerEvents:'none', zIndex:3}} viewBox="0 0 60 55">
      <defs>
        <radialGradient id={`burn-${quest.id}`} cx="0%" cy="0%" r="100%">
          <stop offset="0%" stopColor="#0e0602" stopOpacity="1"/>
          <stop offset="44%" stopColor="#3c1e0a" stopOpacity="0.92"/>
          <stop offset="84%" stopColor="#9e6028" stopOpacity="0.35"/>
          <stop offset="100%" stopColor="#bc8038" stopOpacity="0"/>
        </radialGradient>
      </defs>
      <ellipse cx="0" cy="0" rx="58" ry="52" fill={`url(#burn-${quest.id})`}/>
    </svg>
  ]

  const pinVariant = index % 2
  const pins = [
    // variant 0 — single pin centered
    <div key={0} className="flyer__pin" style={{left: '50%', transform: 'translateX(-50%)'}}></div>,

    // variant 1 — two pins, left and right
    <>
      <div key="pin-l" className="flyer__pin" style={{left: '25%', transform: 'translateX(-50%)'}}></div>
      <div key="pin-r" className="flyer__pin" style={{left: '75%', transform: 'translateX(-50%)'}}></div>
    </>
  ]

  return (
    <motion.div
      className="flyer"
      layoutId={quest.id}
      onMouseEnter={onMouseEnter}
      onClick={onClick}
      style={{
        position: "absolute",
        left: quest.id === zoom ? "50%" : `${slot.x}%`,
        top: quest.id === zoom ? "50%" : `${slot.y}%`,
        x: quest.id === zoom ? "-50%" : 0,
        y: quest.id === zoom ? "-50%" : 0,
        rotate: quest.id === zoom ? 0 : slot.rotation,
        width: quest.id === zoom ? "400px" : "178px",
        zIndex: quest.id === zoom ? 100 : stack.indexOf(index) + 2
      }}
    >
      {quest.id !== zoom && pins[pinVariant]}
      <motion.div className="flyer__paper" layout="position">
        {showBurn && burns[burnVariant]}
        <h3>{quest.title}</h3>
        <span>{quest.description}</span>
        <div className="flyer__reward">¥{Math.round(quest.reward_amount).toLocaleString()}</div>
        <div>
          {quest.id === zoom && <button className="btn btn-mustard w-100 mt-2">Accept Quest</button>}
        </div>
      </motion.div>
    </motion.div>
  )
}

export default Flyer
