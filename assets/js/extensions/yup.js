import * as yup from 'yup';

yup.addMethod(yup.number, 'delocalizeNumber', function () {
    return this.transform(function (currentValue, originalValue) {
        if (!originalValue)
            return 0;
        if (typeof originalValue === 'number')
            return originalValue;
        return parseFloat(String(originalValue).replace(',', '.'))
    })
})