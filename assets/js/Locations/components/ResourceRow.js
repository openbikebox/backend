import React from 'react';
import TableRow from '@material-ui/core/TableRow';
import TableCell from '@material-ui/core/TableCell';
import ListIcon from '@material-ui/icons/List';
import IconButton from '@material-ui/core/IconButton';
import LockOpenIcon from '@material-ui/icons/LockOpen';
import LockIcon from '@material-ui/icons/Lock';
import PropTypes from "prop-types";
import {Link} from 'react-router-dom';
import {locationFullPropType, resourcePropType} from "../models";
import AsyncActionButton from "../../components/AsyncActionButton";
import {requestPost} from "../../Common";



const ResourceRow = (props) => {
    return <TableRow>
        <TableCell>
            {props.resource.id}
        </TableCell>
        <TableCell>
            {props.resource.name}<br/>
            <small>{props.resource.identifier}</small>
        </TableCell>
        <TableCell align="center" style={{display: 'flex'}}>
            <IconButton color="primary" component={Link} to={`/admin/resource/${props.resource.id}/log`}>
                <ListIcon />
            </IconButton>
            <AsyncActionButton
                icon={LockOpenIcon}
                action={async () => {
                    return await requestPost('/api/admin/v1/resource/' + String(props.resource.id) + '/open', {})
                }}
            />
            <AsyncActionButton
                icon={LockIcon}
                action={async () => {
                    return await requestPost('/api/admin/v1/resource/' + String(props.resource.id) + '/close', {})
                }}
            />
        </TableCell>
    </TableRow>
}


ResourceRow.propTypes = {
    location: PropTypes.shape(locationFullPropType),
    resource: PropTypes.shape(resourcePropType)
}

export default ResourceRow;
