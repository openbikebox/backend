import React from "react";
const { Component } = React;

import SwaggerUI from "swagger-ui-react"

export default class ApiDocumentation extends Component {
    render() {
        return (
            <SwaggerUI
                url="/api/documentation/openapi.json"
            />
        )
    }
}
