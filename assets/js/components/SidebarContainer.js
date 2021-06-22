import React from "react";

import Drawer from '@material-ui/core/Drawer';
import Hidden from '@material-ui/core/Hidden';

import {drawerWidth} from "../styles";
import {withStyles, makeStyles} from "@material-ui/core/styles";


const SidebarContainer = (props) => {
    return <nav className={props.classes.drawer}>
        <Hidden smUp implementation="css">
            <Drawer
                variant="temporary"
                open={props.mobileOpen}
                onClose={props.toggleMobileOpen}
                classes={{
                    paper: props.classes.drawerPaper,
                }}
                ModalProps={{
                    keepMounted: true,
                }}
            >
                {props.children}
            </Drawer>
        </Hidden>
        <Hidden xsDown implementation="css">
            <Drawer
                classes={{
                    paper: props.classes.drawerPaper,
                }}
                variant="permanent"
                open
            >
                {props.children}
            </Drawer>
        </Hidden>
    </nav>
}


export default withStyles(theme => ({
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
}))(SidebarContainer);
