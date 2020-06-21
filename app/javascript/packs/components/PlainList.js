import React from "react";
import Plain from "./Plain";

const PlainList = ({plains, onPlainSelect, onPlainsInit, cableHandler}) => {
  const renderList = plains.map(plain => {
    return <Plain plain={plain} key={plain.id} onPlainSelect={onPlainSelect} cableHandler={cableHandler}/>
  })

  if(renderList.length < 1) {
    return (
      <button className="ui primary button" onClick={() => onPlainsInit()}>Add planes to hangar</button>
    )
  }

  return (
    <div className="ui relaxed divided list">{renderList}</div>
  )
}

export default PlainList;
