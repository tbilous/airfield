import React from "react";
import api from "../clients/api";
import PlainList from "./PlainList";

class Airfield extends React.Component {
  state = {plains: []}

  componentDidMount() {
    this.onPlainsLoad().then(
      (response) => this.setState({plains: response.data.plains})
    );
  }

  onPlainsLoad = async () => {
    return await api.get("/plains");
  }

  onPlainsInit = async () => {
    const response = await api.post("/airfields/init");

    this.setState({
      plains: response.data.plains
    })
  }

  onPlainSelect = async plain => {
    await api.post(`/plains/${plain}/take_off`);
  }

  cableHandler = (data) => {
    let arr = this.state.plains
    const index = this.state.plains.findIndex((el) => {
      return el.id === data.id;
    })
    arr[index] = data

    this.setState({
      plains: arr
    })
  }

  render() {
    return (
      <div className="ui container">
        <div className="ui grid">
          <div className="ui row">
            <div className="sixteen wide column">
              <PlainList
                onPlainSelect={this.onPlainSelect}
                onPlainsInit={this.onPlainsInit}
                cableHandler={this.cableHandler}
                plains={this.state.plains}/>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Airfield;
