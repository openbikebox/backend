import React, {useState} from 'react';
import { makeStyles } from '@material-ui/core/styles';
import PropTypes from "prop-types";
import clsx from 'clsx';
import CircularProgress from '@material-ui/core/CircularProgress';
import Fab from '@material-ui/core/Fab';
import MuiAlert from '@material-ui/lab/Alert';
import Snackbar from '@material-ui/core/Snackbar';
import ErrorOutlineIcon from '@material-ui/icons/ErrorOutline';
import InfoOutlinedIcon from '@material-ui/icons/InfoOutlined';
import ReportProblemOutlinedIcon from '@material-ui/icons/ReportProblemOutlined';
import CheckCircleOutlinedIcon from '@material-ui/icons/CheckCircleOutlined';
import { green, yellow, red, blue } from '@material-ui/core/colors';


export const asyncActionButtonStyles = makeStyles((theme) => ({
    root: {
        display: 'flex',
        alignItems: 'center'
    },
    wrapper: {
        margin: 0,
        position: 'relative',
    },
    button:{
    },
    buttonSuccess: {
        backgroundColor: green[500],
        '&:hover': {
            backgroundColor: green[700],
        },
    },
    buttonError: {
        backgroundColor: red[500],
        '&:hover': {
            backgroundColor: red[700],
        },
    },
    buttonWarning: {
        backgroundColor:yellow[500],
        '&:hover': {
            backgroundColor: yellow[700],
        },
    },
    buttonInfo: {
        backgroundColor: blue[500],
        '&:hover': {
            backgroundColor: blue[700],
        },
    },
    fabProgress: {
        color: green[500],
        position: 'absolute',
        top: -4,
        left: -4,
        zIndex: 1,
    }
}));

export const asyncButtonState = {
    idle: 'idle',
    loading: 'loading',
    success: 'success',
    error: 'error',
    info: 'info',
    warning: 'warning'
}

const asyncButtonIcons = {
    [asyncButtonState.success]: CheckCircleOutlinedIcon,
    [asyncButtonState.error]: ErrorOutlineIcon,
    [asyncButtonState.info]: InfoOutlinedIcon,
    [asyncButtonState.warning]: ReportProblemOutlinedIcon,
}

function Alert(props) {
  return <MuiAlert elevation={6} variant="filled" {...props} />;
}


const AsyncActionButton = (props) => {
    const classes = asyncActionButtonStyles();
    const timer = React.useRef();
    const [state, setState] = useState(asyncButtonState.idle);
    const [message, setMessage] = useState();
    const [CurrentIcon, setCurrentIcon] = useState(props.icon);

    const buttonClassname = clsx({
        [classes.button]: true,
        [classes.buttonSuccess]: state === asyncButtonState.success,
        [classes.buttonError]: state === asyncButtonState.error,
        [classes.buttonWarning]: state === asyncButtonState.warning,
        [classes.buttonInfo]: state === asyncButtonState.info,
    });

    React.useEffect(() => {
        setCurrentIcon(Object.keys(asyncButtonIcons).includes(state) ? asyncButtonIcons[state] : props.icon);
    }, [state]);

    React.useEffect(() => {
        return () => {
            clearTimeout(timer.current);
        };
    }, []);

    const handleButtonClick = async () => {
        if (state === asyncButtonState.idle) {
            setState(asyncButtonState.loading);
            const result = await props.action();
            setState(asyncButtonState[result.status]);
            setMessage(result.message);
            timer.current = window.setTimeout(() => {
                setMessage(undefined);
                setState(asyncButtonState.idle);
            }, 3000);
        }
    };

    return <div className={classes.root}>
        <div className={classes.wrapper}>
            <Fab
                aria-label="save"
                color="primary"
                className={buttonClassname}
                onClick={handleButtonClick}
                size={"small"}
            >
                <CurrentIcon />
            </Fab>
            {state === asyncButtonState.loading && <CircularProgress size={48} className={classes.fabProgress} />}
        </div>
        <Snackbar
            open={Object.keys(asyncButtonIcons).includes(state)}
            autoHideDuration={3000}
            anchorOrigin={{ vertical: 'bottom', horizontal: 'left' }}
        >
            <Alert severity="success">
                {message}
            </Alert>
        </Snackbar>
    </div>
}

AsyncActionButton.propTypes = {
    icon: PropTypes.elementType.isRequired,
    action: PropTypes.func.isRequired, // should give back an object with status(success, error) and optional message
}

export default AsyncActionButton;
