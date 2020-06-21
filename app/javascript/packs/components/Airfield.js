import React from "react";
import { findIndex } from "lodash";
import api from "./api";
import PlainList from "./PlainList";

class Airfield extends React.Component {
  constructor(props) {
    super(props);
    this.cableHandler = this.cableHandler.bind(this)
    this.state = { plains: [] }
  }

  componentDidMount() {
    this.onPlainsLoad();
  }

  onPlainsLoad = async () => {
    const response = await api.get("/plains");

    this.setState({
      plains: response.data.plains
    })
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

  cableHandler(plain, data) {
    let arr = this.state.plains
    let index = findIndex(arr, { id: plain.id } )
    arr[index] = data
    this.setState({
      plains: arr
    })

    console.log(this.state.plains)
  }

  render() {
    return(
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
