import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';

import Navbar from './Navbar';
import Welcome from './Welcome';
import Form from './Form';
import Error from './Error';
import Weather from './Weather';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: false,
      weather: null,
      error: null,
    };
    this.randomPlaceSelected = this.randomPlaceSelected.bind(this);
    this.queryPlace = this.queryPlace.bind(this);
    this.maybeRenderError = this.maybeRenderError.bind(this);
    this.maybeRenderWeather = this.maybeRenderWeather.bind(this);
  }

  randomPlaceSelected() {
    this.setState({ loading: true });
    axios.get('/api/weather/random')
         .then((response) => {
           this.setState({ loading: false, weather: response.data, error: null });
         })
         .catch((error) => {
           this.setState({ loading: false, error: error.response.data.message, weather: null });
         });
  }

  queryPlace(city, country) {
    this.setState({ loading: true });
    axios.get(`/api/weather/query?city=${city}&country=${country}`)
         .then((response) => {
           this.setState({ loading: false, weather: response.data, error: null });
         })
         .catch((error) => {
           this.setState({ loading: false, error: error.response.data.message, weather: null });
         });
  }

  maybeRenderError() {
    if (this.state.error) {
      return (<Error message={this.state.error} />);
    }
    return null;
  }

  maybeRenderWeather() {
    if (this.state.weather) {
      return (<Weather weather={this.state.weather} />);
    }
    return null;
  }

  render() {
    return (
      <div>
        <Navbar />
        <div className="container">
          <Welcome />
          <Form
            onRandom={this.randomPlaceSelected}
            onSubmit={this.queryPlace}
            loading={this.state.loading}
          />
          {this.maybeRenderError()}
          {this.maybeRenderWeather()}
        </div>
      </div>
    );
  }
}

const renderApp = () => {
  ReactDOM.render(<App />, document.getElementById('jupiter-react-app'));
};

export default renderApp;
