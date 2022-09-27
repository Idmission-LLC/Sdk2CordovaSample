/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
 */

package com.idmission.sdk.Client;

import android.Manifest;
import android.os.Bundle;
import org.apache.cordova.*;
//import android.support.v4.app.ActivityCompat;
import org.json.JSONArray;
import org.json.JSONException;

import androidx.core.app.ActivityCompat;

public class MainActivity extends CordovaActivity
{
    public static String TAG = "MainActivity";
    public static final int CAMERA_PERMISSION_CODE = 1;
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        // enable Cordova apps to be started in the background
        Bundle extras = getIntent().getExtras();
        if (extras != null && extras.getBoolean("cdvStartInBackground", false)) {
            moveTaskToBack(true);
        }

        // Set by <content src="index.html" /> in config.xml
        loadUrl(launchUrl);
        ActivityCompat.requestPermissions(MainActivity.this, new String[] {
                Manifest.permission.CAMERA,
                Manifest.permission.MODIFY_AUDIO_SETTINGS,
                Manifest.permission.RECORD_AUDIO,
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE}, CAMERA_PERMISSION_CODE);
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        try
        {
            LOG.i(TAG, "onRequestPermissionsResult:permissions : " + new JSONArray(permissions) + ", grantResults:" + new JSONArray(grantResults));
            super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
        catch (JSONException e)
        {
            LOG.d(TAG, "JSONException: Parameters fed into the method are not valid");
            e.printStackTrace();
        }

    }
}
