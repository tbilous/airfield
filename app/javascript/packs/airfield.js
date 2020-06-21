import React from 'react'
import ReactDOM from 'react-dom'
import Airfield from "./components/Airfield";

document.addEventListener('turbolinks:load', () => {
  const app = document.getElementById('airfield')
  app && ReactDOM.render(<Airfield />, app)
})
