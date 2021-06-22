import React from "react";

import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import AccountCircle from '@material-ui/icons/AccountCircle';
import PropTypes from "prop-types";
import {withStyles} from "@material-ui/core/styles";
import {drawerWidth} from "../styles";
import {useTranslation} from "react-i18next";

const Navbar = (props) => {
    const {t} = useTranslation('navbar')

    const classes = props.classes;

    return <AppBar position="fixed" className={classes.appBar}>
        <Toolbar>
            <IconButton
                color="inherit"
                aria-label="open drawer"
                edge="start"
                onClick={props.toggleMobileOpen}
                className={classes.menuButton}
            >
                <MenuIcon/>
            </IconButton>
            <Typography variant="h6" noWrap className={classes.sitetitle}>
                {t('titles.' + props.title)}
            </Typography>
            {props.actions}
            <div className={classes.grow}/>
            <div className={classes.sectionDesktop}>
                <IconButton
                    edge="end"
                    aria-label={t('show-account')}
                    aria-controls="primary-search-account-menu-mobile"
                    aria-haspopup="true"
                    color="inherit"
                >
                    <AccountCircle/>
                </IconButton>
            </div>
        </Toolbar>
    </AppBar>
}

Navbar.propTypes = {
    title: PropTypes.string,
    actions: PropTypes.element
}


export default withStyles((theme) => ({
    appBar: {
        [theme.breakpoints.up('sm')]: {
            width: `calc(100% - ${drawerWidth}px)`,
            marginLeft: drawerWidth,
        },
    },
    menuButton: {
        marginRight: theme.spacing(2),
        [theme.breakpoints.up('sm')]: {
            display: 'none',
        },
    },
    grow: {
        flexGrow: 1,
    },
    sectionDesktop: {
        display: 'none',
        [theme.breakpoints.up('md')]: {
            display: 'flex',
        },
    },
    sectionMobile: {
        display: 'flex',
        [theme.breakpoints.up('md')]: {
            display: 'none',
        },
    },
    sitetitle: {
        marginRight: 10
    }
}))(Navbar);
