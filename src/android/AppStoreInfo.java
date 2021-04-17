package com.appstoreinfo.sese;

import android.content.Context;
import android.content.IntentSender;

import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;

import com.google.android.play.core.appupdate.AppUpdateInfo;
import com.google.android.play.core.appupdate.AppUpdateManager;
import com.google.android.play.core.appupdate.AppUpdateManagerFactory;
import com.google.android.play.core.install.model.AppUpdateType;
import com.google.android.play.core.install.model.UpdateAvailability;
import com.google.android.play.core.tasks.Task;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
//import org.apache.cordova.LOG;


import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
/**
 * This class echoes a string called from JavaScript.
 */
public class AppStoreInfo extends CordovaPlugin {

    @Override
    public void pluginInitialize(){
        //LOG.i("AppStoreInfo inialising");
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

        //Log.i("AppStoreInfo Executing");
        if (action.equals("coolMethod")) {
           // Log.i("Cool Method Executing");

            String message = args.getString(0);

            callbackContext.success("Result: " +message);

            return true;
        }


        if (action.equals("appInfo")) {

            try{
            Context currentContext = (cordova.getActivity()).getBaseContext();
            AppUpdateManager appUpdateManager = AppUpdateManagerFactory.create(currentContext);

            Task<AppUpdateInfo> appUpdateInfoTask = appUpdateManager.getAppUpdateInfo();


            appUpdateInfoTask.addOnSuccessListener(
                appUpdateInfo -> {
                    //this.appUpdateInfo = appUpdateInfo;
                    PackageInfo pInfo = null;
                    try {
                        pInfo = this.getPackageInfo();
                    }
                    catch (PackageManager.NameNotFoundException e) {
                        callbackContext.success("Unable to get App Info");
                        return;
                    }
                    try {
                        JSONObject response = new JSONObject();
                        response.put("installedVersion", String.valueOf(pInfo.versionCode));
                        response.put("availableVersion", String.valueOf(appUpdateInfo.availableVersionCode()));
                        response.put("updateAvailability", appUpdateInfo.updateAvailability());
                        response.put("packageName", appUpdateInfo.packageName());
                        response.put("immediateUpdateAllowed", appUpdateInfo.isUpdateTypeAllowed(AppUpdateType.IMMEDIATE));
                        response.put("flexibleUpdateAllowed", appUpdateInfo.isUpdateTypeAllowed(AppUpdateType.FLEXIBLE));
                        callbackContext.success(response);
                    }
                    catch(JSONException e){
                        callbackContext.success(e.getMessage());
                    }

                    return;
                }
            );
            return true;
            }
            catch (Exception e)
            {
                callbackContext.success(e.getMessage());
            }
        }


        return false;
    }

    private void coolMethod(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }

    private PackageInfo getPackageInfo() throws PackageManager.NameNotFoundException {
        String packageName = this.getContext().getPackageName();
        return this.getContext().getPackageManager().getPackageInfo(packageName, 0);
    }

    private Context getContext() throws PackageManager.NameNotFoundException {
        Context currentContext = (cordova.getActivity()).getBaseContext();
        return currentContext;
    }
}
