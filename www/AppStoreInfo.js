var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'AppStoreInfo', 'coolMethod', [arg0]);
};

exports.appInfo = function (success, error) {
    exec(success, error, 'AppStoreInfo', 'appInfo');
};
