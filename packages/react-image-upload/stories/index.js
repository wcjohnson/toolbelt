import React from 'react';
import { storiesOf, action, linkTo } from '@kadira/storybook';
import Button from './Button';
import Welcome from './Welcome';
import { ImageTest } from './ImageUpload'

var injectTapEventPlugin = require('react-tap-event-plugin');
injectTapEventPlugin();

storiesOf('Welcome', module)
  .add('to Storybook', () => (
    <Welcome showApp={linkTo('Button')}/>
  ));

storiesOf('Button', module)
  .add('with text', () => (
    <Button onClick={action('clicked')}>Hello Button</Button>
  ))
  .add('with some emoji', () => (
    <Button onClick={action('clicked')}>😀 😎 👍 💯</Button>
  ));

storiesOf('ImageUpload', module)
  .add('uploader', () => (
    <div>
      <ImageTest width={512} height={256} />
      <ImageTest width={256} height={512} />
    </div>
  ))
