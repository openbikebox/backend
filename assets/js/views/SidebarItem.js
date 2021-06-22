import React, {useContext, useState} from "react";

import PropTypes from "prop-types";
import {NavLink} from "react-router-dom";
import List from "@material-ui/core/List";
import ListItem from "@material-ui/core/ListItem";
import ListItemText from "@material-ui/core/ListItemText";
import ListItemIcon from "@material-ui/core/ListItemIcon";
import Collapse from '@material-ui/core/Collapse'

import IconExpandLess from '@material-ui/icons/ExpandLess'
import IconExpandMore from '@material-ui/icons/ExpandMore'

import {makeStyles, useTheme} from "@material-ui/core/styles";
import {useTranslation} from "react-i18next";
import {Context as UserContext} from "../models/UserContext";

function SidebarItem(props) {

    const userContext = useContext(UserContext);
    const [hasChildren] = useState(!!(props.route.children && props.route.children.filter(child => child.isMenuLink).length))
    const [childrenOpen, setChildrenOpen] = useState(false)

    const theme = useTheme();
    const classes = (theme) => makeStyles({
        expandIcon: {
            alignItems: 'right',
            minWidth: 'auto'
        },
    })

    const {t} = useTranslation('sidebar');

    const triggerExpand = (evt) => {
        evt.preventDefault();
        evt.stopPropagation();
        setChildrenOpen(!childrenOpen);
    }

    return <>
        <ListItem
            button
            component={NavLink}
            exact={true}
            to={props.route.path}
            onClick={() => setChildrenOpen(true)}
        >
            <ListItemIcon>
                <props.route.icon/>
            </ListItemIcon>
            <ListItemText primary={t(props.route.name)}/>
            {(hasChildren && childrenOpen) &&
            <ListItemIcon onClick={triggerExpand} className={classes.expandIcon}>
                <IconExpandLess/>
            </ListItemIcon>
            }
            {(hasChildren && !childrenOpen) &&
            <ListItemIcon onClick={triggerExpand} className={classes.expandIcon}>
                <IconExpandMore/>
            </ListItemIcon>
            }
        </ListItem>
        {hasChildren && <Collapse in={childrenOpen} timeout="auto" unmountOnExit>
            <List component="div" disablePadding>
                {props.route.children.filter(child => child.isMenuLink && (!child.capability || userContext.hasCapability(child.capability))).map((route, index) => {
                    return <ListItem button component={NavLink} to={route.path} key={route.id}>
                        <ListItemText inset primary={t(route.name)}/>
                    </ListItem>
                })}
            </List>
        </Collapse>}
    </>
}

SidebarItem.propTypes = {
    route: PropTypes.object
}

export default SidebarItem;
