import React from 'react';
import withContentBase from "../../views/ContentBase";
import getBaseStyles from "../../styles";
import { withStyles } from "@material-ui/core/styles";
import {Card, CardContent, CardHeader} from "@material-ui/core";
import { Consumer as UserConsumer } from "../../models/UserContext";


const DashboardRoot = (props) => {
    return <Card>
        <UserConsumer>
            {({info}) => <CardHeader title={'Willkommen, ' + info.first_name + '!'} /> }
        </UserConsumer>
    </Card>
}

export default withStyles(getBaseStyles)(withContentBase(DashboardRoot, 'dashboard.root'));
