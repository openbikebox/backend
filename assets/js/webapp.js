import '../sass/base.scss';
import '../sass/webapp.scss';

import React from "react";
import ReactDOM from "react-dom";
import Root from "./Root";


document.addEventListener("DOMContentLoaded",() => {
    if (document.getElementById('root')) {
         ReactDOM.render(<Root />, document.getElementById('root'));
    }
});

