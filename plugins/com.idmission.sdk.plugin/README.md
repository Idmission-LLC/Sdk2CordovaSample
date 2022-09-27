# IDMissionSDK Ionic Cordova Plugin
======

This plugin is a comprehensive toolkit that offers identity services (e.g. ID validation, live face detection, etc.) for positive identification.

======
## Installation
If you download the plugin 
```
ionic cordova plugin add PATH\IDMissionSDK_Cordova_Plugin_0.0.3
```
Loading it from the GitHub repository
```
ionic cordova plugin add https://github.com/idmission/namePluginCordova.git [Example]
```
## Configurations for Android
#### Minimum Requirements and Initial Setup
The minimum requirements for utilizing this plugin are:
- Android 5.0 or higher
- Active internet connection
- Android Studio 3.6 and above
#### Platform
- If it exists, delete it with **`ionic cordova platform rm android`** and re-create with **`ionic cordova platform add android`**
- If it doesn't exist, create it with **`ionic cordova platform add android`**
#### Prepare Android
- To prepare it, execute **`ionic cordova prepare android`**
#### Dependencies
The plugin needs two dependencies, **idm-imgproc-8.1.4.15.aar** and **OpenCV_4.1.1.aar**. Import the following modules using these steps:
- Navigate to File > Project Structure > Modules
- Click on "+"
- Select a Module Type **Import .JAR/.AAR Package** > Next
- Add **AAR** file path in **File name** and Finish

You can download them from **[link_download]**
#### File `build.gradle`
- Alter file **`build.gradle`** inside the folder **`app`** of the project, add the following information:
```js
android {
    compileSdkVersion 30
    buildToolsVersion '30.0.2'

    dexOptions {
	// incremental true
        javaMaxHeapSize "4g"
    }

    defaultConfig {
        applicationId "com.idmission.libtestproject"
        minSdkVersion 21
        targetSdkVersion 30
        versionCode 20210215
        versionName "8.1.4.15"
        multiDexEnabled true
        ndk {
            // Don't package arm64-v8a or x86_64 , 'x86'
            abiFilters 'armeabi-v7a', 'arm64-v8a'
        }
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }

    dexOptions {
        javaMaxHeapSize "4g"
    }

    lintOptions {
	// checkReleaseBuilds false
        // Or, if you prefer, you can continue to check for errors in release builds,
        // but continue the build even when errors are found:
        abortOnError false
    }

    aaptOptions {
        noCompress "tflite"
    }
    compileOptions {
        sourceCompatibility = '1.8'
        targetCompatibility = '1.8'
    }
}
```
- Find the **`dependencies`** property and add the following lines:
```js
testImplementation 'junit:junit:4.13.1'
implementation 'ch.acra:acra:4.8.5'
implementation 'androidx.appcompat:appcompat:1.2.0'
implementation 'androidx.legacy:legacy-support-v4:1.0.0'
implementation 'com.google.android.material:material:1.3.0-alpha04'
implementation 'com.google.android.gms:play-services-location:17.1.0'
implementation 'com.google.mlkit:face-detection:16.0.2'
implementation 'com.google.android.gms:play-services-mlkit-text-recognition:16.1.1'
implementation 'androidx.constraintlayout:constraintlayout:2.1.0-alpha1'
implementation project(':idm-imgproc-8.1.4.15')
implementation project(':OpenCV_4.1.1')
implementation 'io.fotoapparat:fotoapparat:2.6.1'
implementation 'org.apache.commons:commons-lang3:3.11'
//Passive face detection
implementation 'org.tensorflow:tensorflow-lite:2.3.0'
```
## Configurations for IOS
#### Platform
- If it exists, delete it with **`ionic cordova platform rm ios`** and re-create with **`ionic cordova platform add ios`**
- If it doesn't exist, create it with **`ionic cordova platform add ios`**
#### Prepare IOS
- To prepare it, execute **`ionic cordova prepare ios`**
#### Install Pod
In **`platforms/ios`** install pod:
```js
pod install
```
### Settings in Xcode
- Add the framework **`AppItFramework.framework`** to the root of the project.
  - **Note**: Make sure that the **`Embed`** option of the framework **`AppItFramework.framework`** is in **`Embed & Sign`**
- Add the following files inside the folder **`Classes`**:
  - `evolv_ui_customization.json`
  - `evolv_ui_customization_es.json`
  - `evolv_ui_customization_my.json`
  - `evolv_ui_customization_ar.json`
You can download them at the following link `[download link]`
- Edit the **`MainViewController.h`** file:
  - Add the import: **`#import <AppItFramework/AppItSDK.h>`**
  - And where it says **`@interface MainViewController : CDVViewController`** overwrite it by:
  ```Swift
  @interface MainViewController : CDVViewController<AppItSDKResponse>
  @property (nonatomic, copy, readwrite) NSString *scanCallbackId;
  - (void)sendResponseTo:(NSString *)callbackId withObject:(id)objwithObject;
  + (void)initialize;
  ```
- Edit the **`MainViewController.m`** file:
  - Inside the implementation **`MainViewController`**:
  ```Swift
  #pragma mark - IDMission SDK Methods
  //IDmission SDK Methods - Start
  - (void)sendResponseTo:(NSString *)callbackId withObject:(id)obj
  {
    CDVPluginResult *result = nil;
    if([obj isKindOfClass:[NSString class]]) {
        NSData *data = [obj dataUsingEncoding:NSUTF8StringEncoding];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
    } else if([obj isKindOfClass:[NSDictionary class]]) {
      NSData *jsonData;
      if([NSJSONSerialization isValidJSONObject:obj]) {
        NSError *error;
        jsonData = [
          NSJSONSerialization dataWithJSONObject:obj
          options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
          error:&error
        ];
        if(error) {
          NSLog(@"Got an error: %@", error);
        }
      } else {
        jsonData = obj;
      }
      NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
    } else if ([obj isKindOfClass:[NSNumber class]]) {
      // all the numbers we return are bools
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[obj intValue]];
    } else if(!obj) {
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
      NSLog(@"Success callback wrapper not yet implemented for class %@", [obj class]);
    }
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
  }

  - (void)bankStatementDetectionResponse:(NSMutableDictionary *)result {

  }

  - (void)birthCertificateDetectionResponse:(NSMutableDictionary *)result {

  }

  - (void)captureImageResponse:(NSMutableDictionary *)result {
    NSLog(@"captureImageResponse");
    [self sendResponseTo:self.scanCallbackId withObject:result];
  }

  - (void)captureSignatureResponse:(NSMutableDictionary *)result {
    NSLog(@"captureSignatureResponse");
    NSMutableDictionary *filteredResp = [NSMutableDictionary dictionary];
    [filteredResp setValue:[result objectForKey:@"statusCode"] forKey:@"statusCode"];
    [filteredResp setValue:[result objectForKey:@"StatusCode"] forKey:@"StatusCode"];
    [filteredResp setValue:[result objectForKey:@"signatureImage"] forKey:@"SIGNATURE"];
  }

  - (void)cardDetectionResponse:(NSMutableDictionary *)result {

  }

  - (void)completeOperationResponse:(NSMutableDictionary *)result {

  }

  - (void)createEmployeeResponse:(NSMutableDictionary *)result {

  }

  - (void)executeGenericResponse:(NSMutableDictionary *)result {

  }

  - (void)faceDetectionResponse:(NSMutableDictionary *)result {
    NSLog(@"faceDetectionResponse");
    NSMutableDictionary *filteredResp = [NSMutableDictionary dictionary];
    [filteredResp setValue:[result objectForKey:@"statusCode"] forKey:@"statusCode"];
    [filteredResp setValue:[result objectForKey:@"StatusCode"] forKey:@"StatusCode"];
    [filteredResp setValue:[result objectForKey:@"FACE"] forKey:@"FACE"];
    [self sendResponseTo:self.scanCallbackId withObject:filteredResp];
  }

  - (void)faceMatchingResponse:(NSMutableDictionary *)result {

  }

  - (void)fingerprintEnrolmentResponse:(NSMutableDictionary *)result {

  }

  - (void)fingerprintVerificationResponse:(NSMutableDictionary *)result {

  }

  - (void)fourFingerprintDetectionResponse:(NSMutableDictionary *)result {

  }

  - (void)generateOTPResponse:(NSMutableDictionary *)result {

  }

  - (void)generateTokenResponse:(NSMutableDictionary *)result {

  }

  - (void)genericDocumentResponse:(NSMutableDictionary *)result {

  }

  - (void)gpsCoordinateResponse:(NSMutableDictionary *)result {

  }

  - (void)idValidationAndVideoMatchingResponse:(NSMutableDictionary *)result {

  }

  - (void)initializeSDKResponse:(NSMutableDictionary *)result {
    NSLog(@"initializeSDKResponse");
    [self sendResponseTo:self.scanCallbackId withObject:result];
  }

  - (void)processImageAndFaceMatchingResponse:(NSMutableDictionary *)result {
    NSLog(@"initializeSDKResponse");
    [self sendResponseTo:self.scanCallbackId withObject:result];
  }

  - (void)genericApiCallResponse:(NSMutableDictionary *)result {
    NSLog(@"genericAppiCallResponse");
    [self sendResponseTo:self.scanCallbackId withObject:result];
  }

  - (void)processImageResponse:(NSMutableDictionary *)result {

  }

  - (void)proofOfAddressDetectionResponse:(NSMutableDictionary *)result {

  }

  - (void)scanBarcodeResponse:(NSMutableDictionary *)result {

  }

  - (void)snippetCaptureResponse:(NSMutableDictionary *)result {

  }

  - (void)updateCustomerResponse:(NSMutableDictionary *)result {

  }

  - (void)updateEmployeeResponse:(NSMutableDictionary *)result {

  }

  - (void)updateGenericResponse:(NSMutableDictionary *)result {

  }

  - (void)verifyCustomerResponse:(NSMutableDictionary *)result {

  }

  - (void)verifyEmployeeResponse:(NSMutableDictionary *)result {

  }

  - (void)verifyOTPResponse:(NSMutableDictionary *)result {

  }

  - (void)verifyPOAResponse:(NSMutableDictionary *)result {

  }

  - (void)verifyTokenResponse:(NSMutableDictionary *)result {

  }

  - (void)videoRecordingResponse:(NSMutableDictionary *)result {
      NSLog(@"videoRecordingResponse");
      NSString *filteredResp = [NSString stringWithFormat:@"{\"statusCode\" : \"%@\",\"RECORDING\" : \"%@\"}",[result objectForKey:@"statusCode"],[result objectForKey:@"VIDEO_DATA"]];
      [self sendResponseTo:self.scanCallbackId withObject:filteredResp];
  }

  - (void)voiceRecordingResponse:(NSMutableDictionary *)result {

  }
  //IDmission SDK Methods - End
  ```
## Properties
- idm_sdk_init
- idm_sdk_IdFront
- idm_sdk_IdBack
- idm_sdk_detectFace
- idm_sdk_recordVideo
- idm_sdk_getPermissions (Only Android)
- idm_sdk_CaptureSignature
- idm_sdk_genericApiCall

## Usage
To use the plugin, you need to create an integration user at [EvolvI DMission](https://evolv.idmission.com/eVolv/index) and request the login credentials.
#### idm_sdk_init
It is necessary to execute this function first before the others.

```ts
// all are mandatory parameters
var exampleData = {
  url         : 'https://kyc.idmission.com/IDS/service/integ/idm/thirdparty/upsert',
  loginId     : 'ev_integ_54192',
  password    : 'IDmi#192$',
  merchantID  : '33635',
  productID   : '920',
  productName : 'Identity_Validation_and_Face_Matching',
  Language    : 'en', // You can see the accepted languages in the annexes section
  countryCode : 'USA', // 3 character ISO
  idType      : 'PP', // You can see the Type ID availables in the annexes section
  Service_ID  : '10', // You can see the Services ID availables in the annexes section
  EnableDebug : 'true',
  enableGPS   : 'true'
};
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_init(
    JSON.stringify(exampleData),
    (responseSuccess) => {
        var respJSON = JSON.parse(responseSuccess);
        console.log(respJSON);
    },
    (responseError) => {
        var respJSON = JSON.parse(responseError);
        console.log(respJSON);
    }
);
```
##### JSON success response Android
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success"
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_IdFront
This function will open the camera that will automatically take the photo of the credential.
```ts
/* We can use below config JSON to pass all the feature related configuration parameter, 
if no value is sent it will use default value, All the value should be sent as string*/
captureOptions = {
  id_capture_portrait: "Y", // supported parameter Y/N
  id_light_threshold: "70",
  id_min_focus: "12",
  id_max_focus: "35",
  id_glare_percentage: "5",
  id_enable_capture_button_time: "60",
  id_max_image_size: "500",
  id_image_height: "1170",
  id_image_width: "800",
  id_capture_enable: "N" // supported parameter Y/N
};
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_IdFront(
    JSON.stringify(captureOptions),
    (responseSuccess) => {
        var respJSON = JSON.parse(responseSuccess);
        console.log(respJSON);
    },
    (responseError) => {
        var respJSON = JSON.parse(responseError);
        console.log(respJSON);
    }
);
```
##### JSON success response
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success",
  "FRONT": "", // Base64 Image
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_IdBack
This function will open the camera that will automatically take the photo of the back of the credential.
```ts
/* We can use below config JSON to pass all the feature related configuration parameter, 
if no value is sent it will use default value, All the value should be sent as string*/
captureOptions = {
  id_capture_portrait: "Y", // supported parameter Y/N
  id_light_threshold: "70",
  id_min_focus: "12",
  id_max_focus: "35",
  id_glare_percentage: "5",
  id_enable_capture_button_time: "60",
  id_max_image_size: "500",
  id_image_height: "1170",
  id_image_width: "800",
  id_capture_enable: "N" // supported parameter Y/N
};
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_IdBack(
    JSON.stringify(captureOptions),
    (responseSuccess) => {
        var respJSON = JSON.parse(responseSuccess);
        console.log(respJSON);
    },
    (responseError) => {
        var respJSON = JSON.parse(responseError);
        console.log(respJSON);
    }
);
```
##### JSON success response
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success",
  "BACK": "", // Base64 Image
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_detectFace
This function will open the camera that will automatically take a selfie of the user.
```ts
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_detectFace(
    null,
    (responseSuccess) => {
        var respJSON = JSON.parse(responseSuccess);
        console.log(respJSON);
    },
    (responseError) => {
        var respJSON = JSON.parse(responseError);
        console.log(respJSON);
    }
);
```
##### JSON success response
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success",
  "FACE": "", // Base64 Image
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_recordVideo
This function will open the camera with which you can record.
```ts
var options = {
  recordingTime : 30,
  textDatatoScrolled : 'Hello world! Please let me know how this is recorded to the end of the video.'
};
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_recordVideo(
    JSON.stringify(options),
    (responseSuccess) => {
        var respJSON = JSON.parse(responseSuccess);
        console.log(respJSON);
    },
    (responseError) => {
        var respJSON = JSON.parse(responseError);
        console.log(respJSON);
    }
);
```
##### JSON success response
```JSON
{
  "statusCode": "0",
  "RECORDING": "" // Base64 Video Android - Local file MOV Video iOS
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_getPermissions
Only for Android, you can obtain the permissions of the following native properties:
- CAMERA
- MODIFY_AUDIO_SETTINGS
- RECORD_AUDIO
- READ_EXTERNAL_STORAGE
- WRITE_EXTERNAL_STORAGE
```ts
var permission = {
  permissionName : "CAMERA", // Type Permission
};
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_getPermissions(
    JSON.stringify(permission),
    (responseSuccess) => {
        var respJSON = JSON.parse(responseSuccess);
        console.log(respJSON);
    },
    (responseError) => {
        var respJSON = JSON.parse(responseError);
        console.log(respJSON);
    }
);
```
##### JSON success response
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success"
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_CaptureSignature
This function will open a blank screen where you can capture the signature.
```ts
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_CaptureSignature(
  null,
  (responseSuccess) => {
    var respJSON = JSON.parse(responseSuccess);
    console.log(respJSON);
  },
  (responseError) => {
    var respJSON = JSON.parse(responseError);
    console.log(respJSON);
  }
);
```
##### JSON success response
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success",
  "SIGNATURE": "", // Base64 Image
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
#### idm_sdk_genericApiCall
This function will send the form with the data collected from the previous functions to process the identity of the user to be registered.
```ts
(<any>window).cordova.plugins.IDMissionSDK_Cordova_Plugin.idm_sdk_genericApiCall(
  null,
  (responseSuccess) => {
    var respJSON = JSON.parse(responseSuccess);
    console.log(respJSON);
  },
  (responseError) => {
    var respJSON = JSON.parse(responseError);
    console.log(respJSON);
  }
);
```
##### JSON success response Android
```JSON
{
  "statusCode": "0",
  "statusMessage": "Success",
  "Status_Code": 8052,
  "Status_Message": "",
  "ErrorData": {},
  "Request_Id": 762026308,
  "FormId": 67648369,
  "ProductId": 920
}
```
##### JSON success response iOS
```JSON
{
  "keyArray": [
    "Status_Code",
    "Status_Message",
    "ErrorData",
    "Request_Id",
    "FormId",
    "ProductId",
    "Identity_Validation_and_Face_Matching"
  ],
  "statusCode": "0",
  "statusMessage": "success_msg",
  "Status_Code": "0",
  "Result": {
    "FormId": "",
    "Identity_Validation_and_Face_Matching": "",
    "ProductId": "",
    "ErrorData": "{}",
    "Request_Id": "",
    "Status_Message": "",
    "Status_Code": ""
  }
}
```
##### JSON response
If daily limit forms are exceeded
```JSON
{
  "Status_Code": "",
  "Status_Message": "You have exceeded the limit of "10" forms in "24" hours.",
  "ErrorData": "{}",
  "Request_Id": "",
  "ProductId": "",
  "statusMessage": "",
  "statusCode": "0"
}
```
##### JSON error response
```JSON
{
  "statusCode": "-1",
  "statusMessage": // Error type message
}
```
## Annexes
#### Languages
```
 _ _ _ _ _ _ _ _ _ _ _ _ _
|   English   |    en     |
| - - - - - - - - - - - - |
|   Spanish   |    es     |
| - - - - - - - - - - - - |
|   Myanmar   |    my     |
| - - - - - - - - - - - - |
|    Arabic   |    ar     |
| - - - - - - - - - - - - |
```
#### Types ID
```
 _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|           Passport           |    PP      |
| - - - - - - - - - - - - - - - - - - - - - |
|          National ID         |    NID     |
| - - - - - - - - - - - - - - - - - - - - - |
|         Residence Card       |    RID     |
| - - - - - - - - - - - - - - - - - - - - - |
|         Drivers Licence      |    DL      |
| - - - - - - - - - - - - - - - - - - - - - |
|            Photo ID          |    PID     |
| - - - - - - - - - - - - - - - - - - - - - |
|          Vote ID Card        |    VID     |
| - - - - - - - - - - - - - - - - - - - - - |
|           TAX ID Card        |    TID     |
| - - - - - - - - - - - - - - - - - - - - - |
|        Work Visa Permit      |    WV      |
| - - - - - - - - - - - - - - - - - - - - - |
|      Student Visa Permit     |    SV      |
| - - - - - - - - - - - - - - - - - - - - - |
| Military Police Goverment ID |    GID     |
| - - - - - - - - - - - - - - - - - - - - - |
|       Boat Ship ID Card      |    BID     |
| - - - - - - - - - - - - - - - - - - - - - |
|             Others           |    OTH     |
| - - - - - - - - - - - - - - - - - - - - - |
|       Global Entry Card      |    GE      |
| - - - - - - - - - - - - - - - - - - - - - |
|         Passport Card        |    PPC     |
| - - - - - - - - - - - - - - - - - - - - - |
```
#### Services ID
```
 _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
|                  ID Validation Only                |    20      |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|              ID Validation + Face Match            |    10      |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|  ID Validation + Face Match w/Customer Enrollment  |    50      |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|  ID Validation + Face Match w/Employee Enrollment  |    55      |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|             ID Validation + Video Match            |    155     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| ID Validation + Video Match w/Customer Enrollment  |    160     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| ID Validation + Video Match w/Employee Enrollment  |    165     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|            Customer Enrollment w/Biometrics        |    175     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|            Employee Enrollment w/Biometrics        |    180     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                    Customer Update                 |    70      |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                    Employee Update                 |    75      |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                Customer Verification               |    105     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                Employee Verification               |    305     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|          Identify Customer with Biometrics         |    185     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|          Identify Employee with Biometrics         |    190     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                   Customer Search                  |    186     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                   Employee Search                  |    191     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                  Video Conference                  |    500     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|            IDV + Video Conference Match            |    505     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| IDV + Video Conference Match + Customer Enrollment |    510     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| IDV + Video Conference Match + Employee Enrollment |    515     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|                 ID Data Extraction                 |    620     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
|             Offline Liveness Detection             |    660     |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
```
## Autor

* **IDMission**
* **Colimasoft**