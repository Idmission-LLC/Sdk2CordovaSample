//
//  IDentitySDKHelper.swift
//  IDMissionSDK2_React
//
//  Created by Pranjal Lamba on 29/11/21.
//

import Foundation
import IDentitySDK_Swift
import IDCapture_Swift
import SelfieCapture_Swift

class IDentitySDKHelper : NSObject{
  
  @IBAction func initializeSDK(callbackId: String){

    IDentitySDK.templateModelBaseURL = UserDefaults.templateModelBaseURL
    IDentitySDK.apiBaseURL = UserDefaults.apiBaseURL

    let loginId = UserDefaults.loginId
    let password = UserDefaults.password
    let merchantId = UserDefaults.merchantId
    
    IDentitySDK.initializeSDK(loginId: loginId, password: password, merchantId: merchantId) { error in
        if let error = error {
            print(error.localizedDescription)
            let iDMissionSDK = IDMissionSDK_Cordova_Plugin()
            iDMissionSDK.sendResponse(to: callbackId, with: error.localizedDescription)
        } else {
            print("SDK successfully initialized")
            let iDMissionSDK = IDMissionSDK_Cordova_Plugin()
            iDMissionSDK.sendResponse(to: callbackId, with: "SDK successfully initialized")
        }
    }
  }
  
  // 20 - ID Validation
  @IBAction func startIDValidations(callbackId: String, instances: UIViewController) {
    ViewController().startIDValidation(callbackId: callbackId, instance: instances);
  }
 
  // 10 - ID Validation and Match Face
  @IBAction func startIDValidationAndMatchFaces(callbackId: String, instances: UIViewController) {
    ViewController().startIDValidationAndMatchFace(callbackId: callbackId, instance: instances);
  }
  
  // 50 - ID Validation And Customer Enroll
  @IBAction func startIDValidationAndCustomerEnrolls(params: String, instances: UIViewController) {
    ViewController().startIDValidationAndCustomerEnroll(param: params, instance: instances);
  }
  
  // 175 - Customer Enroll Biometrics
  @IBAction func startCustomerEnrollBiometricss(params: String, instances: UIViewController) {
    ViewController().startCustomerEnrollBiometrics(param: params, instance: instances);
  }
  
  // 105 - Customer Verification
  @IBAction func startCustomerVerifications(params: String, instances: UIViewController) {
    ViewController().startCustomerVerification(param: params, instance: instances);
  }
  
  // 185 - Identify Customer
  @IBAction func startIdentifyCustomers(callbackId: String, instances: UIViewController) {
    ViewController().startIdentifyCustomer(callbackId: callbackId, instance: instances);
  }
  
  // 660 - Live Face Check
  @IBAction func startLiveFaceChecks(callbackId: String, instances: UIViewController) {
    ViewController().startLiveFaceCheck(callbackId: callbackId, instance: instances);
  }
    
  // Submit Result
  @IBAction func submitResults(callbackId: String, instances: UIViewController) {
    ViewController().submitResult(callbackId: callbackId, instance: instances);
  }
}
