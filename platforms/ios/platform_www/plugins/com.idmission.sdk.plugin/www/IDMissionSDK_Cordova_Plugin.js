cordova.define("com.idmission.sdk.plugin.IDMissionSDK_Cordova_Plugin", function(require, exports, module) {
var exec = require('cordova/exec');

exports.idm_sdk_init = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_init', [arg0]);
};

exports.idm_sdk_serviceID20 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID20', [arg0]);
};

exports.idm_sdk_serviceID10 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID10', [arg0]);
};

exports.idm_sdk_serviceID50 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID50', [arg0]);
};

exports.idm_sdk_serviceID175 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID175', [arg0]);
};

exports.idm_sdk_serviceID105 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID105', [arg0]);
};

exports.idm_sdk_serviceID185 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID185', [arg0]);
};

exports.idm_sdk_serviceID660 = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_serviceID660', [arg0]);
};

exports.idm_sdk_submitResult = function (arg0, success, error) {
    exec(success, error, 'IDMissionSDK_Cordova_Plugin', 'idm_sdk_submitResult', [arg0]);
};

});
