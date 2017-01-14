import React from 'react';
import renderer from 'react-test-renderer';

import { App } from '../../web/static/js/ReactApp';

describe('initial app rendering', () => {
  it('renders layout with notifications', () => {
    const subject = renderer.create(<App />);
    expect(subject.toJSON()).toMatchSnapshot();
  });
});
