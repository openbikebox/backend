import React, {createContext, useState, useEffect} from 'react';
import PropTypes from 'prop-types';
import { requestGet } from '../Common';
import {apiPrefix} from "../extensions/config";

export const Context = createContext({});

export const UserProvider = (props) => {
    const [info, _setInfo] = React.useState(props.initialInfo);
    const [loading, setLoading] = useState(false);

    const setInfo = (info) => {
        _setInfo(info);
    }

    const hasCapability = (capability, store_id) => {
        if (store_id && info.store_id && store_id !== info.store_id) {
            return false;
        }
        return info.capabilities.includes(capability) || info.capabilities.includes(UserCapability.ADMIN);
    }

    const getUserInfo = async () => {
        setLoading(true);
        let user_data = (await requestGet(apiPrefix + '/user/self')).data;
        user_data.capabilities = user_data.capabilities.map(capability => UserCapability[capability]);
        setInfo(user_data);
        setLoading(false);
    }

    useEffect(() => {
        getUserInfo();
    },[]);

    const userContext = {
        info,
        hasCapability
    }

    return <Context.Provider value={userContext}>
        {props.children}
    </Context.Provider>
}

export const {Consumer} = Context;

export const userPropTypes = {
    id: PropTypes.number.isRequired,
    store_id: PropTypes.number.isRequired,
    email: PropTypes.string.isRequired,
    capabilities: PropTypes.array.isRequired,
    first_name: PropTypes.string,
    last_name: PropTypes.string
}

UserProvider.propTypes = {
    initialInfo: PropTypes.shape(userPropTypes)
}


UserProvider.defaultProps = {
    initialInfo: {
        capabilities: [],
        id: 0,
        store_id: 0,
        email: ''
    }
}

export const UserCapability = {
    ADMIN: 1
}
