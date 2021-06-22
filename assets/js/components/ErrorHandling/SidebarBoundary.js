import React from 'react';
import SidebarContainer from "../SidebarContainer";
import {Error} from "@material-ui/icons";
import withErrorBoundary from "./BaseErrorBoundary";
import {withTranslation} from "react-i18next";

class SidebarBoundary extends React.Component {
    render() {
        if (this.props.hasError) {
            return <SidebarContainer {...this.properties}>
                <h2><Error/> {this.props.t('heading')}</h2>
                <p>
                    {this.props.t('description', {context: 'render'})}<br/>
                    {this.props.t('action', {context: 'render'})}<br/>
                    {this.props.t('persisting', {context: 'render'})}
                </p>
                <p>{this.props.t('calming_info')}</p>
            </SidebarContainer>
        }
        return this.props.children;
    }
}

export default withTranslation('error')(withErrorBoundary(SidebarBoundary));
