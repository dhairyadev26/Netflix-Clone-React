import React from 'react';
import { render } from 'react-dom';
import { BrowserRouter as Router } from 'react-router-dom';
import { GlobalStyles } from './global-styles';
import App from './app';
import { FirebaseContext } from './context/firebase';
import { firebase } from './lib/firebase.prod';
import 'normalize.css';

render(
  <FirebaseContext.Provider value={{ firebase }}>
    <GlobalStyles />
    <Router>
      <App />
    </Router>
  </FirebaseContext.Provider>,
  document.getElementById('root')
);
