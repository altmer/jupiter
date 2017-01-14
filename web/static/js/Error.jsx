import React, { PropTypes } from 'react';

const Error = props => (
  <div className="row">
    <div className="col-xs-12 error-message">
      {props.message}
    </div>
  </div>
);

Error.propTypes = {
  message: PropTypes.string.isRequired,
};

export default Error;
