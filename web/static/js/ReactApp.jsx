import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import Navbar from './Navbar';
import Welcome from './Welcome';
import Form from './Form';

class App extends Component {
  render() {
    return (
      <div>
        <Navbar />
        <div className="container">
          <Welcome />
          <Form />
        </div>
      </div>
    );
  }
}

const renderApp = () => {
  ReactDOM.render(<App />, document.getElementById('jupiter-react-app'));
};

export default renderApp;
