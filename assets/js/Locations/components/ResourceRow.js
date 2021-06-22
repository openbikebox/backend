import React from 'react';
import TableRow from '@material-ui/core/TableRow';
import TableCell from '@material-ui/core/TableCell';
import ListIcon from '@material-ui/icons/List';
import IconButton from '@material-ui/core/IconButton';
import PropTypes from "prop-types";
import {Link} from 'react-router-dom';
import {locationFullPropType, resourcePropType} from "../models";


const ResourceRow = (props) => {
    return <TableRow>
        <TableCell>
            {props.resource.id}
        </TableCell>
        <TableCell>
            {props.resource.name}<br/>
            <small>{props.resource.identifier}</small>
        </TableCell>
        <TableCell align="center">
            <IconButton color="primary" component={Link} to={`/admin/resource/${props.resource.id}/log`}>
                <ListIcon />
            </IconButton>
        </TableCell>
    </TableRow>
}


ResourceRow.propTypes = {
    location: PropTypes.shape(locationFullPropType),
    resource: PropTypes.shape(resourcePropType)
}

export default ResourceRow;
