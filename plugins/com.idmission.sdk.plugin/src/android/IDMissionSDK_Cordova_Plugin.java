package com.idmission.sdk.plugin;

import android.Manifest;
import android.content.pm.PackageManager;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.util.Base64;
//import android.support.v4.app.ActivityCompat;
//import android.support.v4.content.ContextCompat;

import com.idmission.client.ColorCode;
import com.idmission.client.IdType;
import com.idmission.client.ImageProcessingSDK;
import com.idmission.client.ImageType;

import org.apache.cordova.CordovaActivity;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.apache.cordova.LOG;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.idmission.sdk.plugin.ImageProcessingResponseListenerPluginImpl;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;

/**
 * This class echoes a string called from JavaScript.
 */
public class IDMissionSDK_Cordova_Plugin extends CordovaPlugin {

    private ImageProcessingSDK imageProcessingSDK = null;
    private ImageProcessingResponseListenerPluginImpl listener = null;
    private JSONObject frontBackConfiguration;
    private JSONObject detectFaceConfiguration;
    private JSONObject processConfiguration;
    private HashMap<String, String> englishLabelMap;
    private HashMap<String, String> spanishLabelMap;
    private static final int REQUEST_CODE_1 = 1;

    public IDMissionSDK_Cordova_Plugin() {

        listener = new ImageProcessingResponseListenerPluginImpl();
        frontBackConfiguration = new JSONObject();
        detectFaceConfiguration = new JSONObject();
        processConfiguration = new JSONObject();
        setupLocaledLabels();

        try {
            
            detectFaceConfiguration.put("fd_outline_color" , "D22630");
            detectFaceConfiguration.put("fd_back_button_color" , "D22630");
            detectFaceConfiguration.put("fd_confirm_button_color" , "D22630");
            detectFaceConfiguration.put("fd_detected_face_outline_color" , "F2F2F2");
            detectFaceConfiguration.put("fd_retry_button_color" , "D22630");
            detectFaceConfiguration.put("fd_outside_face_outline_color" , "FFFFFF");
            detectFaceConfiguration.put("fd_label_text_color" , "AF272F");
            detectFaceConfiguration.put("fd_instruction_button_color" , "D22630");
            detectFaceConfiguration.put("fd_header_text_label_color" , "D22630");
            detectFaceConfiguration.put("fd_instruction_button_txt_color" , "FFFFFF");
            detectFaceConfiguration.put("fd_show_instruction_screen" , "N");
            detectFaceConfiguration.put("fd_face_title_label_on_top" , "Y");
            detectFaceConfiguration.put("fd_face_hint_message_on_top" , "N");
            detectFaceConfiguration.put("fd_enable_passive_face_detection","Y");

        } catch (JSONException e) {
            ImageProcessingResponseListenerPluginImpl.sendErrorOnException(e, null);
        }

    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        listener.setActivity((CordovaActivity) cordova.getActivity());
        String message = args.optString(0);

        switch (action) {
            case "idm_sdk_init" :
                idm_sdk_init(message, callbackContext);
                return true;
            case "idm_sdk_IdFront" :
                idm_sdk_IdFront(message, callbackContext);
                return true;
            case "idm_sdk_IdBack" :
                idm_sdk_IdBack(message, callbackContext);
                return true;
            case "idm_sdk_detectFace" :
                idm_sdk_detectFace(message, callbackContext);
                return true;
            case "idm_sdk_recordVideo" :
                idm_sdk_recordVideo(message, callbackContext);
                return true;
            case "idm_sdk_genericApiCall" :
                idm_sdk_genericApiCall(message, callbackContext);
                return true;
            case "idm_sdk_getPermissions" :
                idm_sdk_getPermissions(message, callbackContext);
                return true;
            case "idm_sdk_CaptureSignature" :
                idm_sdk_CaptureSignature(message, callbackContext);
                return true;
            default :
                return false;
        }

    }

    private void setupLocaledLabels () {

        englishLabelMap = new HashMap<String, String>();
        spanishLabelMap = new HashMap<String, String>();

        englishLabelMap.put("align_document_img_capture", "Place the ID inside the borders of the box");
        spanishLabelMap.put("align_document_img_capture", "Coloca la Identificación dentro de los bordes del recuadro");

        englishLabelMap.put("subject_is_too_dark_img_capture", "It's too dark to take a good image. Find a place with better lighting");
        spanishLabelMap.put("subject_is_too_dark_img_capture", "Está demasiado oscuro para tomar una buena imagen. Encuentra un lugar con mejor iluminación");

        englishLabelMap.put("out_of_focus_img_capture", "Tap screen to focus or move camera closer/away");
        spanishLabelMap.put("out_of_focus_img_capture", "Toque la pantalla para enfocar o acercar / alejar la cámara");

        englishLabelMap.put("too_much_glare_img_capture", "Too much light, move document away from direct light");
        spanishLabelMap.put("too_much_glare_img_capture", "Demasiada luz, aleje el documento de la luz directa");

        englishLabelMap.put("subject_is_too_dark_fc_detect", "It's too dark to take a good image. Find a place with better lighting");
        spanishLabelMap.put("subject_is_too_dark_fc_detect", "Está demasiado oscuro para tomar una buena imagen. Encuentra un lugar con mejor iluminación");

        englishLabelMap.put("out_of_focus_fc_detect", "Tap screen to focus or move camera closer/away");
        spanishLabelMap.put("out_of_focus_fc_detect", "Toque la pantalla para enfocar o acercar / alejar la cámara");

        englishLabelMap.put("move_camera_closer_to_your_face", "Move camera closer to face and look towards light");
        spanishLabelMap.put("move_camera_closer_to_your_face", "Acerque la cámara a la cara y mire hacia la luz");

        englishLabelMap.put("camera_movement_fc_detect", "Hold camera steady");
        spanishLabelMap.put("camera_movement_fc_detect", "Mantenga la cámara estable");

        englishLabelMap.put("keep_face_steady", "Keep your face steady");
        spanishLabelMap.put("keep_face_steady", "Mantén la cara firme");

        englishLabelMap.put("smile_please", "Hold camera steady and smile please");
        spanishLabelMap.put("smile_please", "Mantenga la cámara firme y sonríe por favor");

        englishLabelMap.put("face_detected", "Face detected");
        spanishLabelMap.put("face_detected", "Cara detectada");

        englishLabelMap.put("light", "Light %");
        spanishLabelMap.put("light", "% Luz");

        englishLabelMap.put("focus", "Focus %");
        spanishLabelMap.put("focus", "% Foco");

        englishLabelMap.put("glare", "Glare %");
        spanishLabelMap.put("glare", "% Deslumbramiento");

        englishLabelMap.put("smile", "Smile %");
        spanishLabelMap.put("smile", "% Sonrisa");

        englishLabelMap.put("page_title_image_capture", "Capturing identification");
        spanishLabelMap.put("page_title_image_capture", "Capturando identificación");

        englishLabelMap.put("page_title_face_detection", "Detecting face");
        spanishLabelMap.put("page_title_face_detection", "Detectando cara");

        englishLabelMap.put("barcode_detected_error_message", "Barcode is not detected please try again");
        spanishLabelMap.put("barcode_detected_error_message", "Código de barras no detectado, por favor intente de nuevo");

        englishLabelMap.put("capturing_id_scanbarcode", "Scan Barcode");
        spanishLabelMap.put("capturing_id_scanbarcode", "Escanee código de barras");

        englishLabelMap.put("capturing_id_scanbarcode_msg", "Align barcode inside the rectangle and wait");
        spanishLabelMap.put("capturing_id_scanbarcode_msg", "Alinee el código de barras dentro del rectángulo y espere");

        englishLabelMap.put("id_capture_instruction", "Hold your ID straight and steady in front of the camera so the entire image is in view. Avoid excessive backlighting and glare");
        spanishLabelMap.put("id_capture_instruction", "Ubique su ID derecha y fija enfrente de la cámara para que la imagen completa sea visible. Evite el exceso de luz en el fondo y reflejo de luz en la imagen");

        englishLabelMap.put("align_id_and_mrz_inside_rectangle", "Align document and MRZ inside rectangle");
        spanishLabelMap.put("align_id_and_mrz_inside_rectangle", "Alinee el documento y MRZ dentro del rectángulo");

        englishLabelMap.put("align_barcode_inside_rectangle", "Align BARCODE inside rectangle");
        spanishLabelMap.put("align_barcode_inside_rectangle", "Alinee código de barras dentro del rectángulo");

        englishLabelMap.put("barcode_mrz_not_found", "BARCODE or MRZ not found for the selected id");
        spanishLabelMap.put("barcode_mrz_not_found", "No se encontró código de barras o MRZ para la ID seleccionada");

        englishLabelMap.put("capturing_id_scanbarcode_pdf_417_msg", "Align PDF 417 barcode inside the rectangle and wait");
        spanishLabelMap.put("capturing_id_scanbarcode_pdf_417_msg", "Alinee el código de barras PDF 417 dentro del rectángulo y espere");

        englishLabelMap.put("move_id_closer", "Move ID closer");
        spanishLabelMap.put("move_id_closer", "Acerque su ID");
        
        englishLabelMap.put("move_id_away", "Move ID away");
        spanishLabelMap.put("move_id_away", "Aleje su ID");

        englishLabelMap.put("align_document_inside_rectangle", "Align document inside rectangle");
        spanishLabelMap.put("align_document_inside_rectangle", "Alinee el documento dentro del rectángulo");
        
        englishLabelMap.put("id_capture_preview_header", "Check readability");
        spanishLabelMap.put("id_capture_preview_header", "Verifique legibilidad");

        englishLabelMap.put("id_capture_preview_message", "Verify to ensure complete ID is visible with edges and there is no glare or blurred text");
        spanishLabelMap.put("id_capture_preview_message", "Asegure que su ID completa es visible  con los bordes y que no hay reflejo de luz o texto borroso");

        englishLabelMap.put("barcode_error_message", "Barcode is not detected please try again");
        spanishLabelMap.put("barcode_error_message", "Código de barras no detectado, por favor intente de nuevo");

        englishLabelMap.put("mrz_error_message", "MRZ is not detected please try again");
        spanishLabelMap.put("mrz_error_message", "MRZ no detectado, por favor intente de nuevo");

        englishLabelMap.put("barcode_mrz_error_message", "MRZ or Barcode is not detected please try again");
        spanishLabelMap.put("barcode_mrz_error_message", "MRZ o código de barras no detectado, por favor intente de nuevo");

        englishLabelMap.put("id_capture_success_message", "Success");
        spanishLabelMap.put("id_capture_success_message", "Éxito");

        englishLabelMap.put("id_capture_instruction_continue", "Continue");
        spanishLabelMap.put("id_capture_instruction_continue", "Continuar");

    }

    private String readJSONFromAsset(String language) {

        String json = null;
        try {
            InputStream is = cordova.getActivity().getAssets().open("evolv_ui_customization.json");
            if(language == "es") {
                is = cordova.getActivity().getAssets().open("evolv_ui_customization_es.json");
            }
            if(language == "my") {
                is = cordova.getActivity().getAssets().open("evolv_ui_customization_my.json");
            }
            if(language == "ar") {
                is = cordova.getActivity().getAssets().open("evolv_ui_customization_ar.json");
            }
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);
            is.close();
            json = new String(buffer, "UTF-8");
        } catch (IOException ex) {
            ex.printStackTrace();
            return null;
        }
        return json;

    }

    private void idm_sdk_init(String message, CallbackContext callbackContext) throws JSONException {

        JSONObject requestObj = new JSONObject(message);
        String url = requestObj.optString("url");
        String loginID = requestObj.optString("loginId");
        String password = requestObj.optString("password");
        String merchantID = requestObj.optString("merchantID");
        Integer productID = requestObj.optInt("productID");
        String productName = requestObj.optString("productName");
        String language = requestObj.optString("Language");
        boolean enableDebug = requestObj.optBoolean ("EnableDebug");
        boolean enableGPS = requestObj.optBoolean("enableGPS");
        String countryCode = requestObj.optString("countryCode");
        String typeID = requestObj.optString("idType");
        String serviceID = requestObj.optString("Service_ID");

        listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_INIT, callbackContext);
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                try {
                    imageProcessingSDK = ImageProcessingSDK.initialize(cordova.getActivity(), url, loginID, password, merchantID, productID, productName, language, enableDebug);
                    imageProcessingSDK.setImageProcessingResponseListener(listener);
                    String config = readJSONFromAsset(language);
                    imageProcessingSDK.customizeUserInterface(config);
                    imageProcessingSDK.initializeLabels(englishLabelMap, spanishLabelMap);
                    frontBackConfiguration.put("id_country", countryCode);
                    frontBackConfiguration.put("id_type", typeID);
                    processConfiguration.put("countryCode", countryCode);
                    processConfiguration.put("idType", typeID);
                    processConfiguration.put("Service_ID", serviceID);
                    JSONObject response = new JSONObject();
                    response.put("statusCode" , "0");
                    response.put("statusMessage" , "Success");
                    callbackContext.success(response.toString());
                } catch (Exception e) {
                    ImageProcessingResponseListenerPluginImpl.sendErrorOnException(e, callbackContext);
                }
            }
        });

    }

    private void captureConfiguration(JSONObject jsonCaptureConfiguration) {
        try {
            frontBackConfiguration.put("id_capture_portrait", jsonCaptureConfiguration.optString("id_capture_portrait"));
            frontBackConfiguration.put("id_light_threshold", jsonCaptureConfiguration.optString("id_light_threshold"));
            frontBackConfiguration.put("id_min_focus", jsonCaptureConfiguration.optString("id_min_focus"));
            frontBackConfiguration.put("id_max_focus", jsonCaptureConfiguration.optString("id_max_focus"));
            frontBackConfiguration.put("id_glare_percentage", jsonCaptureConfiguration.optString("id_glare_percentage"));
            frontBackConfiguration.put("id_enable_capture_button_time", jsonCaptureConfiguration.optString("id_enable_capture_button_time"));
            frontBackConfiguration.put("id_max_image_size", jsonCaptureConfiguration.optString("id_max_image_size"));
            frontBackConfiguration.put("id_image_height", jsonCaptureConfiguration.optString("id_image_height"));
            frontBackConfiguration.put("id_image_width", jsonCaptureConfiguration.optString("id_image_width"));
            frontBackConfiguration.put("id_capture_enable", jsonCaptureConfiguration.optString("id_capture_enable"));
        } catch (JSONException e) {
            ImageProcessingResponseListenerPluginImpl.sendErrorOnException(e, null);
        }
    }

    private void idm_sdk_IdFront(String message, CallbackContext callbackContext) throws JSONException {

        JSONObject requestObj = new JSONObject(message);
        captureConfiguration(requestObj);
        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_ID_FRONT, callbackContext);
        checkCameraPermissions(Manifest.permission.CAMERA);
        IDMissionSDK_Cordova_Plugin.this.imageProcessingSDK.autoCapture(cordova.getActivity(), ImageType.FRONT, frontBackConfiguration, new JSONObject(), new HashMap<String,String>());

    }

    private void idm_sdk_IdBack(String message, CallbackContext callbackContext) throws JSONException {
        
        JSONObject requestObj = new JSONObject(message);
        captureConfiguration(requestObj);
        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_ID_BACK, callbackContext);
        checkCameraPermissions(Manifest.permission.CAMERA);
        IDMissionSDK_Cordova_Plugin.this.imageProcessingSDK.autoCapture(cordova.getActivity(), ImageType.BACK, frontBackConfiguration, new JSONObject(), new HashMap<String,String>());

    }

    private void idm_sdk_detectFace(String message, CallbackContext callbackContext) throws JSONException {

        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_DETECT_FACE, callbackContext);
        checkCameraPermissions(Manifest.permission.CAMERA);
        Bitmap captureBitmap = ImageProcessingSDK.getTitleImageCaptureBitmap();
        
        if(null != captureBitmap) {
            String titleImageString = bitmapToBase64(captureBitmap);
            if (!titleImageString.isEmpty()) {
                detectFaceConfiguration.put("fd_title_img_bitmap_base64",titleImageString);
            }
        }
        IDMissionSDK_Cordova_Plugin.this.imageProcessingSDK.detectFace(cordova.getActivity(), detectFaceConfiguration);

    }

    private void idm_sdk_CaptureSignature(String message, CallbackContext callbackContext) throws JSONException {

        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_CAPTURE_SIGNATURE, callbackContext);
        IDMissionSDK_Cordova_Plugin.this.imageProcessingSDK.captureSignature(cordova.getActivity());

    }

    private void idm_sdk_recordVideo(String message, CallbackContext callbackContext) throws JSONException {

        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_RECORD_VIDEO, callbackContext);
        checkCameraPermissions(Manifest.permission.CAMERA);
        checkCameraPermissions(Manifest.permission.MODIFY_AUDIO_SETTINGS);
        checkCameraPermissions(Manifest.permission.RECORD_AUDIO);
        checkCameraPermissions(Manifest.permission.READ_EXTERNAL_STORAGE);
        checkCameraPermissions(Manifest.permission.WRITE_EXTERNAL_STORAGE);
        JSONObject requestObj = new JSONObject(message);
        int recordingTime = requestObj.optInt("recordingTime", 10);
        String textDatatoScrolled = requestObj.optString("textDatatoScrolled", "No data provided");
        IDMissionSDK_Cordova_Plugin.this.imageProcessingSDK.startVideoRecording(cordova.getActivity(), recordingTime, requestObj, textDatatoScrolled);

    }

    private void idm_sdk_genericApiCall(String message, CallbackContext callbackContext) throws JSONException {

        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_GENERIC_API_CALL, callbackContext);
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                try {
                    JSONObject requestObj = new JSONObject();
                    requestObj.put("country_id", processConfiguration.optString("id_country"));
                    requestObj.put("state_id", "");
                    requestObj.put("id_type", processConfiguration.optString("id_type"));
                    JSONObject additionalDataJSON = new JSONObject();
                    additionalDataJSON.put("Unique_Customer_Number", "");
                    additionalDataJSON.put("Service_ID", processConfiguration.optString("Service_ID"));
                    requestObj.put("additionalDataJSON", additionalDataJSON);
                    requestObj.put("clear_form_key", "Y");
                    IDMissionSDK_Cordova_Plugin.this.imageProcessingSDK.genericApiCall(cordova.getActivity(), requestObj);
                } catch (Exception e) {
                    ImageProcessingResponseListenerPluginImpl.sendErrorOnException(e, callbackContext);
                }
            }
        });

    }

    private void idm_sdk_getPermissions(String message, CallbackContext callbackContext) throws JSONException {

        this.listener.setCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_GET_PERMISSIONS, callbackContext);
        JSONObject requestObj = new JSONObject(message);
        String whichPermission = requestObj.getString("permissionName");
        checkCameraPermissions(whichPermission);

    }

    private void checkCameraPermissions(String whichPermission) {

        if (!cordova.hasPermission(whichPermission)) {
            cordova.getThreadPool().execute(new Runnable() {
                public void run() {
                    cordova.requestPermission(IDMissionSDK_Cordova_Plugin.this, REQUEST_CODE_1, whichPermission);
                }
            });
        }
    }

    @Override
    public void onRequestPermissionResult(int requestCode, String[] permissions, int[] grantResults) throws JSONException {
        try{
            LOG.d(IDMissionSDK_Cordova_Plugin.class.getSimpleName(), "onRequestPermissionResult : permissiong " + Arrays.asList(permissions) + ": grants - " + new JSONArray(grantResults));
            JSONObject response = new JSONObject();
            response.put("statusCode" , "0");
            response.put("statusMessage" , "Success");
            this.listener.getCallbackContext(ImageProcessingResponseListenerPluginImpl.IDM_SDK_GET_PERMISSIONS).success(response.toString());
        } catch(Exception e) {
            LOG.e("onRequestPermissionsResult", "Error while sending error", e);
        }
        
    }



    private IdType getIdTypeFromValue(String idTypeStr) {
        for (IdType type : IdType.values()) {
            if (type.getIdType().equalsIgnoreCase(idTypeStr)) {
                return type;
            }
        }
        return IdType.OTHERS;
    }
    
    public static String bitmapToBase64(Bitmap bmp) {
            if (bmp == null || bmp.isRecycled())
                return "";
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            bmp.compress(Bitmap.CompressFormat.JPEG, 90, baos); // bm is the bitmap
    // object
            byte[] b = baos.toByteArray();
            String imageBase64= Base64.encodeToString(b, Base64.DEFAULT);

            return imageBase64;
        }
        
}
