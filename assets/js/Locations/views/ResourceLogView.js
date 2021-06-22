import React, {useEffect, useState} from 'react';
import {useParams} from "react-router";
import Paper from '@material-ui/core/Paper';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';
import TableFooter  from '@material-ui/core/TableFooter';
import TablePagination from '@material-ui/core/TablePagination';
import Typography from "@material-ui/core/Typography";
import LogRow from "../components/LogRow";
import withContentBase from "../../views/ContentBase";
import {requestGet} from "../../Common";
import {apiPrefix} from "../../extensions/config";
import {Link} from "react-router-dom";
import SyncIcon from '@material-ui/icons/Sync';
import IconButton from "@material-ui/core/IconButton";


const ResourceLogView = (props) => {
    const {resource_id} = useParams();

    const [entries, setEntries] = React.useState([]);
    const [entriesCount, setEntriesCount] = React.useState(0);
    const [searchParams, setSearchParams] = React.useState(defaultSeachParams)
    const [loading, setLoading] = useState(false);

    const getEntriesData = async () => {
        setLoading(true);
        let result = await requestGet(apiPrefix + '/resource/' + String(resource_id) + '/logs?page=' + String(searchParams.page + 1) + '&items_per_page=' + String(searchParams.items_per_page));
        setEntries(result.data);
        setEntriesCount(result.count);
        setLoading(false);
    }

    const handleChangePage = (event, newPage) => {
        setSearchParams({...searchParams, ...{page: newPage}});
    };

    const handleChangeRowsPerPage = (event) => {
        setSearchParams({...searchParams, ...{
            items_per_page: parseInt(event.target.value, 10),
            page: 0
        }})
    };

    useEffect(() => {
        getEntriesData();
    }, [searchParams]);


    return <TableContainer component={Paper}>
        <Typography style={{padding: '16px'}} variant={'h6'}>
            {entriesCount} Log-Einträge
            <IconButton color="primary" onClick={(evt) => {evt.preventDefault(); getEntriesData();}}>
                <SyncIcon />
            </IconButton>
        </Typography>
        <Table>
            <TableHead>
                <TableRow>
                    <TableCell>ID</TableCell>
                    <TableCell>Zeitpunkt</TableCell>
                    <TableCell>Typ</TableCell>
                    <TableCell>Nachricht</TableCell>
                </TableRow>
            </TableHead>
            <TableBody>
                {entries.map(entry => <LogRow
                    key={`resource-${entry.id}`}
                    entry={entry}
                />)}
            </TableBody>
            <TableFooter>
                <TableRow>
                    <TablePagination
                        rowsPerPageOptions={[5, 10, 25, 50, 100]}
                        colSpan={5}
                        count={entriesCount}
                        rowsPerPage={searchParams.items_per_page}
                        page={searchParams.page}
                        onChangePage={handleChangePage}
                        onChangeRowsPerPage={handleChangeRowsPerPage}
                    />
                </TableRow>
            </TableFooter>
        </Table>
    </TableContainer>
}

const defaultSeachParams = {
    page: 0,
    items_per_page: 25
}

export default withContentBase(ResourceLogView, 'resources.log');
