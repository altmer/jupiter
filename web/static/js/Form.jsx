import React, { Component, PropTypes } from 'react';
import CountryList from 'country-list';

const countries = CountryList();
const renderCountries = () => (
  countries.getCodes().map(code => (
    <option key={code} value={code}>{countries.getName(code)}</option>
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
    this.submitForm = this.submitForm.bind(this);
  }

  handleChange(event) {
    this.setState({
      [event.target.name]: event.target.value,
    });
  }

  submitForm(event) {
    event.preventDefault();
    this.props.onSubmit(this.state.city, this.state.country);
  }

  render() {
    return (
      <div className="jupiter-form">
        <div className="row">
          <div className="col-xs-12">
            <form className="form-inline" onSubmit={this.submitForm}>
              <div className="form-group">
                <div className="input-group">
                  <input
                    type="text"
                    name="city"
                    className="form-control"
                    placeholder="City name"
                    value={this.state.city}
                    onChange={this.handleChange}
                    disabled={this.props.loading}
                    autoFocus
                  />
                  <select
                    name="country"
                    className="form-control select-country"
                    value={this.state.country}
                    onChange={this.handleChange}
                    disabled={this.props.loading}
                  >
                    {renderCountries()}
                  </select>
                  <span className="input-group-btn">
                    <button
                      type="submit"
                      className="btn btn-primary"
                      disabled={this.props.loading}
                    >
                      Get weather
                    </button>
                  </span>
                </div>
              </div>
            </form>
          </div>
        </div>
        <div className="row lucky-form">
          <div className="col-xs-12">
            <div className="lucky-text">OR...</div>
            <a
              href="#0"
              className="btn btn-default"
              onClick={this.props.onRandom}
              disabled={this.props.loading}
            >
              Feeling lucky!
            </a>
          </div>
        </div>
      </div>
    );
  }
}

Form.propTypes = {
  onRandom: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired,
  loading: PropTypes.bool.isRequired,
};

export default Form;
