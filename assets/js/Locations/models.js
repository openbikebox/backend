import PropTypes from "prop-types";


export const logEntryPropType = {
    client_id: PropTypes.number,
    created: PropTypes.string,
    data: PropTypes.object,
    modified: PropTypes.string,
    state: PropTypes.oneOf(['request', 'reply']),
    type: PropTypes.oneOf([
        'BootNotification', 'RemoteChangeResourceStatus', 'ResourceStatusChange', 'Authorize', 'DoorStatus',
        'Exception', 'ConnectionChange'
    ]),
    uid: PropTypes.string,
}

export const fileLightPropType = {
    id: PropTypes.number.isRequired,
    mimetype: PropTypes.string,
    modified: PropTypes.string,
    url: PropTypes.string
}

export const fileFullPropType = {
    ...fileLightPropType,
    created: PropTypes.string,
    id_url: PropTypes.string
}

export const pricegroupPropType = {
    created: PropTypes.string,
    detailed_calculation: PropTypes.bool,
    fee_day: PropTypes.string,
    fee_hour: PropTypes.string,
    fee_month: PropTypes.string,
    fee_week: PropTypes.string,
    fee_year: PropTypes.string,
    id: PropTypes.number.isRequired,
    modified: PropTypes.string
}

export const resourcePropType = {
    id: PropTypes.number.isRequired,
    created: PropTypes.string,
    description: PropTypes.string,
    id_url: PropTypes.string,
    identifier: PropTypes.string,
    installed_at: PropTypes.string,
    modified: PropTypes.string,
    slug: PropTypes.string,
    status: PropTypes.oneOf(['free', 'taken', 'reserved', 'inactive', 'faulted']),
    pricegroup: PropTypes.shape(pricegroupPropType),
    predefined_dateranges: PropTypes.arrayOf(PropTypes.oneOf(['day', 'week', 'month', 'year'])),
    photo: PropTypes.shape(fileFullPropType),
    photos: PropTypes.arrayOf(PropTypes.shape(fileFullPropType))
}

export const operatorPropType = {
      address: PropTypes.string,
      country: PropTypes.string,
      created: PropTypes.string,
      id: PropTypes.number,
      id_url: PropTypes.string,
      locality: PropTypes.string,
      logo: PropTypes.shape(fileFullPropType),
      modified: PropTypes.string,
      name: PropTypes.string,
      postalcode: PropTypes.string
}

export const locationLightPropType = {
    id: PropTypes.number.isRequired,
    booking_url: PropTypes.string,
    ressource_count: PropTypes.number,
    slug: PropTypes.string,
    id_url: PropTypes.string,
    lat: PropTypes.number,
    lon: PropTypes.number,
    name: PropTypes.string,
    photo: PropTypes.shape(fileLightPropType)
}

export const locationFullPropType = {
    ...locationLightPropType,
    address: PropTypes.string,
    booking_base_url: PropTypes.string,
    country: PropTypes.string,
    created: PropTypes.string,
    description: PropTypes.string,
    locality: PropTypes.string,
    modified: PropTypes.string,
    operator: PropTypes.shape(operatorPropType),
    operator_id: PropTypes.number,
    photo_id: PropTypes.number,
    postalcode: PropTypes.string,
    photo: PropTypes.shape(fileFullPropType),
    resource: PropTypes.arrayOf(PropTypes.shape(resourcePropType)),
    twentyfourseven: PropTypes.bool,
    type: PropTypes.oneOf(['bikebox', 'cargobike'])
}

