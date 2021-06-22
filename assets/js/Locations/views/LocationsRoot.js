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
import LocationRow from "../components/LocationRow";
import withContentBase from "../../views/ContentBase";
import {requestGet} from "../../Common";
import {publicApiPrefix} from "../../extensions/config";


const LocationsRoot = (props) => {

    const [locations, setLocations] = React.useState([]);
    const [locationCount, setLocationCount] = React.useState(0);
    const [loading, setLoading] = useState(false);

    const getLocationData = async () => {
        setLoading(true);
        let result = await requestGet(publicApiPrefix + '/locations');
        setLocations(result.data);
        setLocationCount(result.data.length);
        setLoading(false);
    }

    useEffect(() => {
        getLocationData();
    }, []);


    return <TableContainer component={Paper}>
        <Typography style={{padding: '16px'}} variant={'h6'}>
            {locationCount} Standorte
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
                {locations.map(location => <LocationRow key={`location-${location.id}`} location={location}/>)}
            </TableBody>
        </Table>
    </TableContainer>
}

export default withContentBase(LocationsRoot, 'locations.root');
