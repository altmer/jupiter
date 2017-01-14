import React, { PropTypes } from 'react';

const Weather = props => (
  <div className="weather-info">
    <div className="row">
      <div className="col-xs-12">
        <h3>
          {props.weather.name} {props.weather.temperature > 0 ? '+' : ''}
          {props.weather.temperature} °C
        </h3>
      </div>
    </div>
    <div className="row">
      <div className="col-xs-12">
        {props.weather.category} ({props.weather.description})
        <br />
        Pressure {props.weather.pressure} hPa
        <br />
        Wind {props.weather.wind_speed} meter/sec
      </div>
    </div>
    <div className="row coordinates">
      <div className="col-xs-12">
        Lat: {props.weather.lat}, Lon: {props.weather.lon}
      </div>
    </div>
  </div>
);

Weather.propTypes = {
  weather: PropTypes.shape({
    name: PropTypes.string,
    lat: PropTypes.number,
    lon: PropTypes.number,
    temperature: PropTypes.number,
    pressure: PropTypes.number,
    wind_speed: PropTypes.number,
    category: PropTypes.string,
    description: PropTypes.string,
  }).isRequired,
};

export default Weather;
