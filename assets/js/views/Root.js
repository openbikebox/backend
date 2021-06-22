import React from "react";
import {BrowserRouter as Router, Route, Switch} from "react-router-dom";
import {ThemeProvider} from '@material-ui/core/styles';
import {createMuiTheme} from "@material-ui/core";
import {withStyles} from "@material-ui/core/styles";
import {withTranslation} from 'react-i18next';
import CssBaseline from '@material-ui/core/CssBaseline';
import MomentUtils from '@date-io/moment';
import {MuiPickersUtilsProvider} from '@material-ui/pickers';
import SidebarBoundary from "../components/ErrorHandling/SidebarBoundary";
import getBaseStyles from '../styles';
import Sidebar from './Sidebar';
import routes from "../routes";
import {UserProvider} from "../models/UserContext";

const Root = (props) => {
    const [mobileOpen, setMobileOpen] = React.useState(false);

    const [stateRoutes, setStateRoutes] = React.useState(() => {
        let ret = [];
        Object.values(routes).forEach(parent => {
            ret.push(parent);
            if (!parent.children)
                return;
            parent.children.forEach(child1 => {
                if (!child1.isFullPath)
                    child1.path = parent.path + child1.path;
                ret.push(child1);
                if (!child1.children)
                    return;
                child1.children.forEach(child2 => {
                    child2.path = child1.path + child2.path;
                    ret.push(child2);
                });
            });
        });
        return ret;
    });


    const toggleMobileOpen = () => {
        setMobileOpen(!mobileOpen);
    }

    const theme = createMuiTheme();


    return <div className={props.classes.root}>
        <ThemeProvider theme={theme}>
            <MuiPickersUtilsProvider utils={MomentUtils}>
                <UserProvider value={null}>
                    <Router>
                        <CssBaseline/>
                        <SidebarBoundary mobileOpen={mobileOpen} toggleMobileOpen={toggleMobileOpen}>
                            <Sidebar
                                mobileOpen={mobileOpen}
                                toggleMobileOpen={toggleMobileOpen}
                                t={props.t}
                            />
                        </SidebarBoundary>
                        <Switch>
                            {stateRoutes.map((route, id) => {
                                return <Route
                                    key={`route-${id}`}
                                    path={route.path}
                                    exact={!!route.exact}
                                >
                                    <route.component
                                        baseClasses={props.classes}
                                        t={props.t}
                                        toggleMobileOpen={toggleMobileOpen}
                                    />
                                </Route>
                            })}
                        </Switch>
                    </Router>
                </UserProvider>
            </MuiPickersUtilsProvider>
        </ThemeProvider>
    </div>
}

export default withTranslation()(withStyles(getBaseStyles)(Root));
