import React, {useContext} from 'react';
import TableRow from '@material-ui/core/TableRow';
import TableCell from '@material-ui/core/TableCell';
import ListIcon from '@material-ui/icons/List';
import IconButton from '@material-ui/core/IconButton';
import PropTypes from "prop-types";
import {Link} from 'react-router-dom';
import {locationLightPropType} from "../models";


const LocationRow = (props) => {

    return <TableRow>
        <TableCell>
            {props.location.id}
        </TableCell>
        <TableCell>
            {props.location.name}
        </TableCell>
        <TableCell align="center">
            <IconButton color="primary" component={Link} to={`/admin/location/${props.location.id}/resources`}>
                <ListIcon />
            </IconButton>
        </TableCell>
    </TableRow>
}

LocationRow.propTypes = {
    location: PropTypes.shape(locationLightPropType),
}

export default LocationRow;
