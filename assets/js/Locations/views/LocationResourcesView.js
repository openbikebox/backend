import React, {useEffect, useState} from 'react';
import Paper from '@material-ui/core/Paper';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import PropTypes from "prop-types";
import Typography from "@material-ui/core/Typography";
import ResourceRow from "../components/ResourceRow";
import withContentBase from "../../views/ContentBase";
import {requestGet} from "../../Common";
import {publicApiPrefix} from "../../extensions/config";
import {useParams} from "react-router";


const LocationResources = (props) => {
    const {location_id} = useParams();

    const [location, setLocation] = React.useState();
    const [resources, setResources] = React.useState([]);
    const [resourceCount, setResourceCount] = React.useState(0);
    const [loading, setLoading] = useState(false);

    const getResourcesData = async () => {
        setLoading(true);
        let result = await requestGet(publicApiPrefix + '/location/' + String(location_id));
        setResources(result.data.resource);
        setResourceCount(result.data.resource.length);
        setLoading(false);
    }

    useEffect(() => {
        getResourcesData();
    }, []);


    return <TableContainer component={Paper}>
        <Typography style={{padding: '16px'}} variant={'h6'}>
            {resourceCount} Ressourcen
        </Typography>
        <Table>
            <TableHead>
                <TableRow>
                    <TableCell>ID</TableCell>
                    <TableCell>Name</TableCell>
                    <TableCell align="center">Aktionen</TableCell>
                </TableRow>
            </TableHead>
            <TableBody>
                {resources.map(resource => <ResourceRow
                    key={`resource-${resource.id}`}
                    location={location}
                    resource={resource}
                />)}
            </TableBody>
        </Table>
    </TableContainer>
}


export default withContentBase(LocationResources, 'locations.resources');
