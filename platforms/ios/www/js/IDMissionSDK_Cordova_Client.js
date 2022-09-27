function callIdm_sdk_init() {
	idm_log('callIdm_sdk_init!');
	var sdkInitiCaller = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_init(
            JSON.stringify(sdkInitiCaller),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_init - response - ' + response);
                //var parentElement = document.getElementById('initResultWrapper');
                //parentElement.innerHTML = "SDK Initialization Status: " + response;
                alert("SDK Initialization Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_init - error - ' + error);
                //var parentElement = document.getElementById('initResultWrapper');
                //parentElement.innerHTML = "SDK Initialization Status: " + error;
                alert("SDK Initialization Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID20() {
	idm_log('callIdm_sdk_serviceID20 called!');
	var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID20(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID20 - response - ' + response);
                //var parentElement = document.getElementById('serviceID20ResultWrapper');
                //parentElement.innerHTML = "Service ID 20 Status: " + response;
                alert("Service ID 20 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID20 - error - ' + error);
                //var parentElement = document.getElementById('serviceID20ResultWrapper');
                //parentElement.innerHTML = "Service ID 20 Status: " + error;
                alert("Service ID 20 Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID10() {
    idm_log('callIdm_sdk_serviceID10 called!');
    var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID10(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID10 - response - ' + response);
                //var parentElement = document.getElementById('serviceID10ResultWrapper');
                //parentElement.innerHTML = "Service ID 10 Status: " + response;
                alert("Service ID 10 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID10 - error - ' + error);
                //var parentElement = document.getElementById('serviceID10ResultWrapper');
                //parentElement.innerHTML = "Service ID 10 Status: " + error;
                alert("Service ID 10 Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID50() {
    idm_log('callIdm_sdk_serviceID50 called!');
    var uniqueNumber = document.getElementById('uniqueNumber').value;
    var sdkConfig = {"uniqueNumber":uniqueNumber};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID50(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID50 - response - ' + response);
                //var parentElement = document.getElementById('serviceID50ResultWrapper');
                //parentElement.innerHTML = "Service ID 50 Status: " + response;
                alert("Service ID 50 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID50 - error - ' + error);
                //var parentElement = document.getElementById('serviceID50ResultWrapper');
                //parentElement.innerHTML = "Service ID 50 Status: " + error;
                alert("Service ID 50 Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID175() {
    idm_log('callIdm_sdk_serviceID175 called!');
    var uniqueNumber = document.getElementById('uniqueNumber').value;
    var sdkConfig = {"uniqueNumber":uniqueNumber};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID175(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID175 - response - ' + response);
                //var parentElement = document.getElementById('serviceID175ResultWrapper');
                //parentElement.innerHTML = "Service ID 175 Status: " + response;
                alert("Service ID 175 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID175 - error - ' + error);
                //var parentElement = document.getElementById('serviceID175ResultWrapper');
                //parentElement.innerHTML = "Service ID 175 Status: " + error;
                alert("Service ID 175 Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID105() {
    idm_log('callIdm_sdk_serviceID105 called!');
    var uniqueNumber = document.getElementById('uniqueNumber').value;
    var sdkConfig = {"uniqueNumber":uniqueNumber};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID105(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID105 - response - ' + response);
                //var parentElement = document.getElementById('serviceID105ResultWrapper');
                //parentElement.innerHTML = "Service ID 105 Status: " + response;
                alert("Service ID 105 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID105 - error - ' + error);
                //var parentElement = document.getElementById('serviceID105ResultWrapper');
                //parentElement.innerHTML = "Service ID 105 Status: " + error;
                alert("Service ID 105 Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID185() {
    idm_log('callIdm_sdk_serviceID185 called!');
    var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID185(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID185 - response - ' + response);
                //var parentElement = document.getElementById('serviceID185ResultWrapper');
                //parentElement.innerHTML = "Service ID 185 Status: " + response;
                alert("Service ID 185 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID185 - error - ' + error);
                //var parentElement = document.getElementById('serviceID185ResultWrapper');
                //parentElement.innerHTML = "Service ID 185 Status: " + error;
                alert("Service ID 185 Status: " + error);
            }
            );
}

function callIdm_sdk_serviceID660() {
    idm_log('callIdm_sdk_serviceID660 called!');
    var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_serviceID660(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_serviceID660 - response - ' + response);
                //var parentElement = document.getElementById('serviceID660ResultWrapper');
                //parentElement.innerHTML = "Service ID 660 Status: " + response;
                alert("Service ID 660 Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_serviceID660 - error - ' + error);
                //var parentElement = document.getElementById('serviceID660ResultWrapper');
                //parentElement.innerHTML = "Service ID 660 Status: " + error;
                alert("Service ID 660 Status: " + error);
            }
            );
}

function callIdm_sdk_submitResult() {
    idm_log('callIdm_sdk_submitResult called!');
    var sdkConfig = {};
    cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_submitResult(
            JSON.stringify(sdkConfig),
            function(response){
                //Success Handler.
                idm_log('callIdm_sdk_submitResult - response - ' + response);
                alert("Submit Result Status: " + response);
            },
            function(error){
                idm_log('callIdm_sdk_submitResult - error - ' + error);
                alert("Submit Result Status: " + error);
            }
            );
}

function idm_createImage(imgStr, wrappingIdvId) {
	var imgTag = '<img style="max-height: 50%; max-width: 80%;" src="data:image/jpeg;base64, ' + imgStr + '" />';
	var parentElement = document.getElementById(wrappingIdvId);
	parentElement.innerHTML = imgTag;
}


function idm_log(msg) {
	console.log('-js-log-' + msg);
}
