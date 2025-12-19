import React from 'react'

function Main() {
  return (
    <div className="main-container">
      <canvas 
        width="800" 
        height="600"
        style={{
          width: '100%',
          height: '100%',
          objectFit: 'contain'
        }}
      >
        Your browser does not support the HTML5 canvas element.
      </canvas>
      <p>Controls: Tap the screen above to toggle the state</p>
    </div>
  )
}

export default Main