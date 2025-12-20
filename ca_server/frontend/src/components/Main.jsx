import React from 'react'

function Main() {
  return (
    <div className="main-container">
      <canvas 
        width="400" 
        height="600"
        style={{
          width: '100%',
          height: '100%',
          objectFit: 'contain'
        }}
      >
        Your browser does not support the HTML5 canvas element.
      </canvas>
      <p>Tap the simulation area above ☝️</p>
    </div>
  )
}

export default Main