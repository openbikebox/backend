import green from '@material-ui/core/colors/green';
import red from '@material-ui/core/colors/red';
export const drawerWidth = 260;

const getBaseStyles = (theme) => {
    return {
        root: {
            display: 'flex',
        },
        toolbar: theme.mixins.toolbar,
        content: {
            flexGrow: 1,
            padding: theme.spacing(3),
        },
        contentSubTitle: {
            marginBottom: theme.spacing(3),
            padding: theme.spacing(1)
        },
        leftContainer: {
            marginLeft: 0,
            paddingLeft: 0
        },
        navbarPopupMenu: {
            alignContent: 'center',
            display: 'flex',
        },
        lowercaseButton: {
            textTransform: 'none'
        },
        notificationButton: {
            textTransform: 'none',
            width: '100%',
            overflow: 'auto',
        },
        absoluteEndIcon: {
            position: 'absolute',
            right: '1rem',
            top: '25%'
        },
        srOnly: {
            border: 0,
            clip: 'rect(0 0 0 0)',
            height: 1,
            margin: -1,
            overflow: 'hidden',
            padding: 0,
            position: 'absolute',
            top: 20,
            width: 1,
        },
        modalBody: {
            position: 'absolute',
            top: '5%',

            [theme.breakpoints.up('lg')]: {
                left: '12.5%',
                width: '75%'
            },
            [theme.breakpoints.down('lg')]: {
                left: '10%',
                width: '80%'
            },
            [theme.breakpoints.down('md')]: {
                left: '5%',
                width: '90%'
            },
            [theme.breakpoints.down('sm')]: {
                width: '100%'
            },
        },
        buttonContainer: {
            '& > *': {
                margin: theme.spacing(1),
            },
        },
        buttonSuccess: {
            color: 'white',
            backgroundColor: green[700],
            '&:hover': {
                background: green[600]
            }
        },
        buttonDanger: {
            color: 'white',
            backgroundColor: red[700],
            '&:hover': {
                background: red[600]
            }
        },
        checkboxMini: {
            padding: 0
        }
    }
};

export default getBaseStyles;
