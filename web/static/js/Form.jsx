import React, { Component } from 'react';
import CountryList from 'country-list';

const countries = CountryList();
const renderCountries = () => (
  countries.getCodes().map(code => (
    <option value={code}>{countries.getName(code)}</option>
  ))
);

class Form extends Component {
  constructor(props) {
    super(props);
    this.state = {
      country: 'DE',
      city: 'Berlin',
    };
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value,
    });
  }

  render() {
    return (
      <div className="jupiter-form">
        <div className="row">
          <div className="col-xs-12">
            <form className="form-inline">
              <div className="form-group">
                <div className="input-group">
                  <input
                    type="text"
                    name="city"
                    className="form-control"
                    placeholder="City name"
                    value={this.state.city}
                    onChange={this.handleChange}
                  />
                  <select
                    name="country"
                    className="form-control select-country"
                    value={this.state.country}
                    onChange={this.handleChange}
                  >
                    {renderCountries()}
                  </select>
                  <span className="input-group-btn">
                    <a href="#0" className="btn btn-primary">
                      Get weather
                    </a>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
        <div className="row lucky-form">
          <div className="col-xs-12">
            <div className="lucky-text">OR...</div>
            <a href="#0" className="btn btn-default">
              Feeling lucky!
            </a>
          </div>
        </div>
      </div>
    );
  }
}

export default Form;
