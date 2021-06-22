import React from 'react';
import TableRow from '@material-ui/core/TableRow';
import TableCell from '@material-ui/core/TableCell';
import PropTypes from "prop-types";
import {logEntryPropType} from "../models";
import {formatDateTime} from '../../Format';


const LogRow = (props) => {
    return <TableRow>
        <TableCell>
            {props.entry.id}
        </TableCell>
        <TableCell>
            {formatDateTime(props.entry.created)}
        </TableCell>
        <TableCell>
            {props.entry.type}{(!!props.entry.state) && <>{props.entry.state.charAt(0).toUpperCase()}{props.entry.state.slice(1)}</>}
        </TableCell>
        <TableCell>
            {JSON.stringify(props.entry.data)}
        </TableCell>
    </TableRow>
}


LogRow.propTypes = {
    entry: PropTypes.shape(logEntryPropType)
}

export default LogRow;
