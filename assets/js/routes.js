import HomeIcon from '@material-ui/icons/Home';
import PlaceIcon from '@material-ui/icons/Place';

import LocationRoutes from './Locations/routes';

import Dashboard from "./Dashboard/main";
import Locations from "./Locations/main";


const routes = {
    dashboard: {
        path: '/admin',
        name: 'dashboard.root',
        component: Dashboard,
        icon: HomeIcon,
        exact: true
    },
    locations: {
        path: '/admin/locations',
        name: 'locations.root',
        component: Locations,
        icon: PlaceIcon,
        children: LocationRoutes,
        exact: true
    }
}

export default routes;
