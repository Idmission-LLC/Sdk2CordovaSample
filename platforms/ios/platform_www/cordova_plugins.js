cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "cordova-plugin-inappbrowser.inappbrowser",
      "file": "plugins/cordova-plugin-inappbrowser/www/inappbrowser.js",
      "pluginId": "cordova-plugin-inappbrowser",
      "clobbers": [
        "cordova.InAppBrowser.open"
      ]
    },
    {
      "id": "com.idmission.sdk.plugin.IDMissionSDK_Cordova_Plugin",
      "file": "plugins/com.idmission.sdk.plugin/www/IDMissionSDK_Cordova_Plugin.js",
      "pluginId": "com.idmission.sdk.plugin",
      "clobbers": [
        "cordova.plugins.IDMissionSDK_Cordova_Plugin"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-whitelist": "1.3.4",
    "cordova-plugin-inappbrowser": "5.0.0",
    "com.idmission.sdk.plugin": "0.0.3"
  };
});