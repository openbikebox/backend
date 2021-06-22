import moment from 'moment';

export const formatDateTime = (value) => {
    if (!value)
        return '';
    return moment(value).format('DD.MM., HH:mm');
}
