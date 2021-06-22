import '../sass/base.scss';
import '../sass/webapp.scss';

import React, { Suspense } from "react";
import ReactDOM from "react-dom";
import Root from "./views/Root";

import './extensions/i18n';

document.addEventListener("DOMContentLoaded",() => {
    if (document.getElementById('root')) {
         ReactDOM.render(<Suspense fallback="loading">
             <Root />
         </Suspense>,
         document.getElementById('root'));
    }
});

