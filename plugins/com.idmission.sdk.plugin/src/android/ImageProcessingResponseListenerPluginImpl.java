package com.idmission.sdk.plugin;

import com.idmission.client.ImageProcessingResponseListener;
import com.idmission.client.Response;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaActivity;
import org.apache.cordova.LOG;
import org.json.JSONObject;

import java.util.Hashtable;
import java.util.Map;

public class ImageProcessingResponseListenerPluginImpl implements ImageProcessingResponseListener {

    public  static  final String IDM_SDK_INIT = "idm_sdk_init";
    public  static  final String IDM_SDK_ID_FRONT = "idm_sdk_IdFront";
    public  static  final String IDM_SDK_ID_BACK = "idm_sdk_IdBack";
    public  static  final String IDM_SDK_DETECT_FACE = "idm_sdk_detectFace";
    public  static  final String IDM_SDK_RECORD_VIDEO = "idm_sdk_recordVideo";
    public  static  final String IDM_SDK_GENERIC_API_CALL = "idm_sdk_genericApiCall";
    public  static  final String IDM_SDK_GET_PERMISSIONS = "idm_sdk_getPermissions";
    public  static  final String IDM_SDK_CAPTURE_SIGNATURE = "idm_sdk_CaptureSignature";

    private CordovaActivity activity = null;
    private Map<String, CallbackContext> callbackContexts = new Hashtable<String, CallbackContext>();


    @Override
    public void onImageProcessingResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onAutoImageCaptureResultAvailable(Map<String, String> map, Response response) {

        LOG.i(ImageProcessingResponseListenerPluginImpl.class.getSimpleName(), "onAutoImageCaptureResultAvailable received");
        CallbackContext callbackContext = null;
        String value = null;
        try {
            JSONObject respObject = new JSONObject(map);
            respObject.put("statusMessage", response.getStatusMessage());
            respObject.put("statusCode", response.getStatusCode());
            if (respObject.has("FRONT")) {
                callbackContext = this.callbackContexts.get(IDM_SDK_ID_FRONT);
                value = map.get("FRONT");
                respObject.put("FRONT", value);
            } else {
                callbackContext = this.callbackContexts.get(IDM_SDK_ID_BACK);
                value = map.get("BACK");
                respObject.put("BACK", value);
            }
            if ( response.getStatusCode() == 0 ) {
                callbackContext.success(respObject.toString());
            } else {
                callbackContext.error(respObject.toString());
            }
        } catch (Throwable t) {
            sendErrorOnException(t, callbackContext);
        }

    }

    @Override
    public void onFaceDetectionResultAvailable(Map<String, String> map, Response response) {

        LOG.i(ImageProcessingResponseListenerPluginImpl.class.getSimpleName(), "onFaceDetectionResultAvailable received");
        CallbackContext callbackContext = this.callbackContexts.get(IDM_SDK_DETECT_FACE);
        try {
            String value = map.get("FACE");
            JSONObject respObject = new JSONObject();
            respObject.put("statusMessage", response.getStatusMessage());
            respObject.put("statusCode", response.getStatusCode());
            respObject.put("FACE", value);
            if ( response.getStatusCode() == 0 ) {
                callbackContext.success(respObject.toString());
            } else {
                callbackContext.error(respObject.toString());
            }
        } catch (Throwable t) {
            sendErrorOnException(t, callbackContext);
        }

    }

    @Override
    public void onFaceMatchingResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCardDetectionResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCaptureProofOfAddressResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCaptureBankStatementResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCaptureGenericDocumentResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCaptureBirthCertificateResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onImageProcessingAndFaceMatchingResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onOperationResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCustomerVerificationResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onCustomizeUserInterfaceResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onVoiceRecordingFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onGPSCoordinateAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onFourFingerCaptureFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onFingerprintCaptureFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onFingerprintEnrolmentFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onFingerprintVerificationFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onVideoRecordingFinished(Map<String, String> map, Response response) {

        LOG.i(ImageProcessingResponseListenerPluginImpl.class.getSimpleName(), "onVideoRecordingFinished received");
        CallbackContext callbackContext = this.callbackContexts.get(IDM_SDK_RECORD_VIDEO);
        try {
            String value = map.get("DATA");
            JSONObject respObject = new JSONObject();
            respObject.put("statusMessage", response.getStatusMessage());
            respObject.put("statusCode", response.getStatusCode());
            respObject.put("RECORDING", value);
            if ( response.getStatusCode() == 0 ) {
                callbackContext.success(respObject.toString());
            } else {
                callbackContext.error(respObject.toString());
            }
        } catch (Throwable t) {
            sendErrorOnException(t, callbackContext);
        }

    }

    @Override
    public void onScanBarcodeFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onCaptureSignatureFinished(Map<String, String> map, Response response) {

        LOG.i(ImageProcessingResponseListenerPluginImpl.class.getSimpleName(), "onCaptureSignatureFinished received");
        CallbackContext callbackContext = this.callbackContexts.get(IDM_SDK_CAPTURE_SIGNATURE);
        try {
            String value = map.get("SignatureImage");
            JSONObject respObject = new JSONObject();
            respObject.put("statusMessage", response.getStatusMessage());
            respObject.put("statusCode", response.getStatusCode());
            respObject.put("SIGNATURE", value);
            if ( response.getStatusCode() == 0 ) {
                callbackContext.success(respObject.toString());
            } else {
                callbackContext.error(respObject.toString());
            }
        } catch (Throwable t) {
            sendErrorOnException(t, callbackContext);
        }
    }

    @Override
    public void onVerifyAddressFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onCreateEmployeeFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onVerifyEmployeeFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onGenerateTokenFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onVerifyTokenFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onSnippetImageCaptureResultAvailable(Map<String, String> map, Response response) {

    }

    @Override
    public void onUpdateCustomerFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onGenerateOTPFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onVerifyOTPFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onInitializationResultAvailable(Map<String, String> map, Response response) {

        CallbackContext callbackContext = this.callbackContexts.get(IDM_SDK_INIT);
        try {

            JSONObject respObject = new JSONObject();
            respObject.put("statusMessage", response.getStatusMessage());
            respObject.put("statusCode", response.getStatusCode());
            //respObject.put("Result", map);

            if ( response.getStatusCode() == 0 ) {
                callbackContext.success(respObject.toString());
            } else {
                callbackContext.error(respObject.toString());
            }
        } catch (Throwable t) {
            sendErrorOnException(t, callbackContext);
        }
    }

    @Override
    public void onExecuteCustomProductCall(Map<String, String> map, Response response) {

    }

    @Override
    public void onUpdateEmployeeFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onIDValidationAndVideoMatchingFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void genericApiCallResponse(Map<String, String> map, Response response) {

        LOG.i(ImageProcessingResponseListenerPluginImpl.class.getSimpleName(), "genericApiCallResponse received");
        CallbackContext callbackContext = this.callbackContexts.get(IDM_SDK_GENERIC_API_CALL);
        try {
            LOG.i("SEND DATA",map.toString());
            JSONObject respObject = new JSONObject(map);
            respObject.put("statusMessage", response.getStatusMessage());
            respObject.put("statusCode", response.getStatusCode());
            if ( response.getStatusCode() == 0 ) {
                callbackContext.success(respObject.toString());
            } else {
                callbackContext.error(respObject.toString());
            }
        } catch (Throwable t) {
            sendErrorOnException(t, callbackContext);
        }

    }

    @Override
    public void onVideoConferencingFinished(Map<String, String> map, Response response) {

    }

    @Override
    public void onDownloadXsltResultAvailable(Map<String, String> map, Response response) {

    }
    
    @Override
    public void onAutoFillFieldInformationAvailable(Map<String,String> map, Response response) {

    }

    @Override
    public void onAutoFillResultAvailable(Map<String,String> map, Response response) {

    }

    public void setActivity(CordovaActivity activity) {
        this.activity = activity;
    }

    public void setCallbackContext(String operationName, CallbackContext callbackContext) {
        this.callbackContexts.put(operationName, callbackContext);
    }
    public CallbackContext getCallbackContext(String operationName) {
        return this.callbackContexts.get(operationName);
    }

    public static void sendErrorOnException(Throwable t, CallbackContext callbackContext) {
        try {
            JSONObject response = new JSONObject();
            response.put("statusCode" , "-1");
            response.put("statusMessage" , t.getLocalizedMessage());
            if (callbackContext != null) {
                callbackContext.error(response.toString());
            }
        } catch (Exception e) {
            LOG.e( ImageProcessingResponseListenerPluginImpl.class.getName(), "Error while sending error", e);
        }
    }
}
