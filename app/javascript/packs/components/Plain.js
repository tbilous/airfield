import React from "react";
import cable from "actioncable";
import './Plain.css'
import appConfig from "./config";

class Plain extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      position: props.plain.state,
      history: props.plain.history,
      flyable: this.setFlyAble(props.plain.state)}
    this.cable = cable.createConsumer(appConfig.ws_root)
    this.canvasChannel = this.cable.subscriptions.create({
      channel: `PlainChannel`,
      plain_id: props.plain.id
    },{
      connected: () => {
        console.log(`Connected plain_${props.plain.id}`)
      },
      received: data => {
        this.props.cableHandler(this.props.plain, data)
        this.setState({
          position: data.state,
          history: data.history,
          flyable: this.setFlyAble(data.state)
        })
      }
    })
  }

  setFlyAble = state => {
    return state === 'hangar'
  }

  sendToFly = plane => {
    if(this.state.flyable) {
      return this.props.onPlainSelect(plane.id)
    }
    return undefined
  }

  render() {
    return(
    <div onClick={() => this.sendToFly(this.props.plain)}>
      <div className="ui segment">
        <div className={this.state.position}>
          <div className="ui list">
            <div>Current position: {this.state.position}</div>
            {
              React.Children.toArray(
                this.state.history.map((l) => <div key={l.id}>Added to {l.state}: {l.created}</div>)
              )
            }
          </div>
        </div>
      </div>
    </div>
    )
  }
}

export default Plain;
