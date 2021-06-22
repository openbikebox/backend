import LocationResourcesView from './views/LocationResourcesView';
import ResourceLogView from './views/ResourceLogView';

const routes = [
    {
        id: 'location-resources',
        path: '/admin/location/:location_id(\\d+)/resources',
        component: LocationResourcesView,
        isFullPath: true
    },
    {
        id: 'resource-log',
        path: '/admin/resource/:resource_id(\\d+)/log',
        component: ResourceLogView,
        isFullPath: true
    }
]

export default routes;
