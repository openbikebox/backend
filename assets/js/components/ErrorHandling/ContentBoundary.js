import React from "react";
import {Card, CardContent, CardHeader} from "@material-ui/core";
import {withTranslation} from "react-i18next";
import {Error} from "@material-ui/icons";
import withErrorBoundary from "./BaseErrorBoundary";

class ContentBoundary extends React.Component {
    render() {
        if (this.props.hasError) {
            return <Card>
                <CardHeader title={<><Error/> {this.props.t('heading')}</>}/>
                <CardContent>
                    <p>
                        {this.props.t('description', {context: 'render'})}<br/>
                        {this.props.t('action', {context: 'render'})}<br/>
                        {this.props.t('persisting', {context: 'render'})}
                    </p>
                    <p>{this.props.t('calming_info')}</p>
                </CardContent>
            </Card>
        }
        return this.props.children;
    }
}

export default withTranslation('error')(withErrorBoundary(ContentBoundary))
