import React from "react";
import '../styles/Plain.css'
import cableDispatcher from "../clients/cable";

const Plain = ({plain, onPlainSelect, cableHandler}) => {
  cableDispatcher(
    {channel: "PlainChannel", id: plain.id},
    cableHandler
  )

  const sendToFly = plane => {
    if (plain.state === 'hangar') {
      return onPlainSelect(plane.id)
    }
    return undefined
  }

  return (
    <div onClick={() => sendToFly(plain)}>
      <div className="ui segment">
        <div className={plain.state}>
          <div className="ui list">
            <div>Current position: {plain.state}</div>
            {plain.history.map((h) => <div key={h.id}>Added to {h.state}: {h.created}</div>)}
          </div>
        </div>
      </div>
    </div>
  )
}

export default Plain;
