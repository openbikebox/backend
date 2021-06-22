import React from "react";

import List from "@material-ui/core/List";

import routes from "../routes";
import {drawerWidth} from "../styles";
import {withStyles} from "@material-ui/core/styles";

import SidebarItem from './SidebarItem';
import SidebarContainer from "../components/SidebarContainer";
import { Consumer, UserCapability } from '../models/UserContext';


const Sidebar = (props) => {
    const renderDrawer = () => {
        return <div>
            <div className={props.classes.toolbar}/>
            <Consumer>
                {({hasCapability}) =>
                    <List component="div">
                        <SidebarItem route={routes.dashboard} />
                        <SidebarItem route={routes.locations} />
                    </List>
                }
            </Consumer>
        </div>
    }

    return <SidebarContainer {...props}>{renderDrawer()}</SidebarContainer>
}

export default withStyles((theme) => ({
    toolbar: theme.mixins.toolbar,
    drawer: {
        [theme.breakpoints.up('sm')]: {
            width: drawerWidth,
            flexShrink: 0,
        },
    },
    drawerPaper: {
        width: drawerWidth,
    },
}))(Sidebar);
