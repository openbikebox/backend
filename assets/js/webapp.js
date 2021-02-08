import '../sass/base.scss';
import '../sass/webapp.scss';

import React from "react";
import ReactDOM from "react-dom";

import ApiDocumentation from "./api-documentation/main";


document.addEventListener("DOMContentLoaded",() => {
    let reactObjects = {
        'api-documentation': ApiDocumentation
    };
    for (const [html_id, ReactClass] of Object.entries(reactObjects)) {
        if (document.getElementById(html_id)) {
            ReactDOM.render(
                <ReactClass ref={(reactClass) => {window[ReactClass.name.charAt(0).toLowerCase() + ReactClass.name.slice(1)] = reactClass}} />,
                document.getElementById(html_id)
            );
        }
    }

});

