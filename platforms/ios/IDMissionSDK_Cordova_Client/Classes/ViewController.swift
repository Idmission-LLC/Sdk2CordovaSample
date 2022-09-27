//
//  ViewController.swift
//  IDentitySample
//
//  Created by Stefan Kaczmarek on 8/29/21.
//

import UIKit
import IDentitySDK_Swift
import IDCapture_Swift
import SelfieCapture_Swift

extension AdditionalCustomerWFlagCommonData {
    init(serviceOptions options: ServiceOptions) {
        let manualReviewRequired: AdditionalCustomerWFlagCommonData.ManualReviewRequired
        switch options.manualReviewRequired {
        case .yes: manualReviewRequired = .yes
        case .no: manualReviewRequired = .no
        case .forced: manualReviewRequired = .forced
        }

        self = AdditionalCustomerWFlagCommonData(manualReviewRequired: manualReviewRequired,
                                                 bypassAgeValidation: options.bypassAgeValidation ? .yes : .no,
                                                 deDuplicationRequired: options.deDuplicationRequired ? .yes : .no,
                                                 bypassNameMatching: options.bypassNameMatching ? .yes : .no,
                                                 postDataAPIRequired: options.postDataAPIRequired ? .yes : .no,
                                                 sendInputImagesInPost: options.sendInputImagesInPost ? .yes : .no,
                                                 sendProcessedImagesInPost: options.sendProcessedImagesInPost ? .yes : .no,
                                                 needImmediateResponse: options.needImmediateResponse ? .yes : .no,
                                                 deduplicationSynchronous: options.deduplicationSynchronous ? .yes : .no,
                                                 verifyDataWithHost: options.verifyDataWithHost ? .yes : .no,
                                                 idBackImageRequired: options.idBackImageRequired ? .yes : .no,
                                                 stripSpecialCharacters: options.stripSpecialCharacters ? .yes : .no)
    }
}

extension AdditionalCustomerEnrollBiometricRequestData {
    init(serviceOptions options: ServiceOptions) {
        self = AdditionalCustomerEnrollBiometricRequestData(needImmediateResponse: options.needImmediateResponse ? .yes : .no,
                                                            deDuplicationRequired: options.deDuplicationRequired ? .yes : .no)
    }
}

var validateIdResult2: ValidateIdResult?                             // 20
var validateIdMatchFaceResult2: ValidateIdMatchFaceResult?           // 10
var customerEnrollResult2: CustomerEnrollResult?                     // 50
var customerEnrollBiometricsResult2: CustomerEnrollBiometricsResult? // 175
var customerVerificationResult2: CustomerVerificationResult?         // 105
var customerIdentifyResult2: CustomerIdentifyResult?                 // 185
var liveFaceCheckResult2: LiveFaceCheckResult?                       // 660

class ViewController: UIViewController {
    var texts: String!
    var textObfuscated: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - IBAction Methods

    // 20 - ID Validation
    func startIDValidation(callbackId: String, instance: UIViewController) {
        // start ID capture, presenting it from this view controller
        let options = AdditionalCustomerWFlagCommonData(serviceOptions: UserDefaults.serviceOptions)
        IDentitySDK.idValidation(from: instance, options: options) { result in
            switch result {
            case .success(let validateIdResult):
              self.emptyResults()
              validateIdResult2 = validateIdResult

                // pretty print the request object
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                if let _ = validateIdResult2, var request = IDentitySDK.customerValidateIdRequest {
                    // stub out the base64 image text for logging
                    request.customerData.idData.idImageFront = "..."
                    if request.customerData.idData.idImageBack != nil {
                        request.customerData.idData.idImageBack = "..."
                    }
                    let requestObfuscated = request
                  
                    if let data = try? encoder.encode(request),
                       let json = String(data: data, encoding: .utf8)  {
                        self.texts = json
                    } else {
                        self.texts = "ERROR"
                    }
                  
                    if let dataObfuscated = try? encoder.encode(requestObfuscated),
                       let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                        self.textObfuscated = jsonObfuscated
                    } else {
                        self.textObfuscated = "ERROR"
                    }
                }
                
                self.sendData(callbackId: callbackId, text: self.texts)
            case .failure(let error):
              print(error.localizedDescription)
                self.sendData(callbackId: callbackId, text: error.localizedDescription)
            }
        }
      
    }
  
    // 10 - ID Validation and Match Face
    func startIDValidationAndMatchFace(callbackId: String, instance: UIViewController) {
        let options = AdditionalCustomerWFlagCommonData(serviceOptions: UserDefaults.serviceOptions)
        IDentitySDK.idValidationAndMatchFace(from: instance, options: options) { result in
            switch result {
            case .success(let validateIdMatchFaceResult):
              self.emptyResults()
              validateIdMatchFaceResult2=validateIdMatchFaceResult
                // pretty print the request object
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                
                if let _ = validateIdMatchFaceResult2, var request = IDentitySDK.customerValidateIdFaceMatchRequest {
                    // stub out the base64 image texts for logging
                    request.customerData.idData.idImageFront = "..."
                    if request.customerData.idData.idImageBack != nil {
                        request.customerData.idData.idImageBack = "..."
                    }
                    request.customerData.biometericData.selfie = "..."
                    let requestObfuscated = request
                  
                    if let data = try? encoder.encode(request),
                       let json = String(data: data, encoding: .utf8)  {
                        self.texts = json
                    } else {
                        self.texts = "ERROR"
                    }
                  
                    if let dataObfuscated = try? encoder.encode(requestObfuscated),
                       let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                        self.textObfuscated = jsonObfuscated
                    } else {
                        self.textObfuscated = "ERROR"
                    }
                }
                
                self.sendData(callbackId: callbackId, text: self.texts)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(callbackId: callbackId, text: error.localizedDescription)
            }
        }
    }

    // 50 - ID Validation And Customer Enroll
      func startIDValidationAndCustomerEnroll(param: String, instance: UIViewController) {
            var uniqueNumber: String!
            var callbackId: String!
            do{
                if let json = param.data(using: String.Encoding.utf8){
                    if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                        uniqueNumber = jsonData["uniqueNumber"] as? String
                        callbackId = jsonData["callbackId"] as? String
                    }
                }
            }catch {
                print(error.localizedDescription)
            }
          let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
          let options = AdditionalCustomerWFlagCommonData(serviceOptions: UserDefaults.serviceOptions)
          IDentitySDK.idValidationAndCustomerEnroll(from: instance, personalData: personalData, options: options) { result in
              switch result {
              case .success(let customerEnrollResult):
                self.emptyResults()
                customerEnrollResult2=customerEnrollResult
                  
                  // pretty print the request object
                  let encoder = JSONEncoder()
                  encoder.outputFormatting = .prettyPrinted
                  
                  if let _ = customerEnrollResult2, var request = IDentitySDK.customerEnrollRequest {
                      // stub out the base64 image text for logging
                      request.customerData.idData.idImageFront = "..."
                      if request.customerData.idData.idImageBack != nil {
                          request.customerData.idData.idImageBack = "..."
                      }
                      request.customerData.biometericData.selfie = "..."
                      let requestObfuscated = request
                    
                      if let data = try? encoder.encode(request),
                         let json = String(data: data, encoding: .utf8)  {
                          self.texts = json
                      } else {
                          self.texts = "ERROR"
                      }
                    
                      if let dataObfuscated = try? encoder.encode(requestObfuscated),
                         let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                          self.textObfuscated = jsonObfuscated
                      } else {
                          self.textObfuscated = "ERROR"
                      }
                  }
                  
                  self.sendData(callbackId: callbackId, text: self.texts)
              case .failure(let error):
                  print(error.localizedDescription)
                  self.sendData(callbackId: callbackId, text: error.localizedDescription)
              }
          }
      }
  
    // 175 - Customer Enroll Biometrics
    func startCustomerEnrollBiometrics(param: String, instance: UIViewController) {
        var uniqueNumber: String!
        var callbackId: String!
        do{
            if let json = param.data(using: String.Encoding.utf8){
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                    uniqueNumber = jsonData["uniqueNumber"] as? String
                    callbackId = jsonData["callbackId"] as? String
                }
            }
        }catch {
            print(error.localizedDescription)
        }
        let personalData = PersonalCustomerCommonRequestData(uniqueNumber: uniqueNumber)
        let options = AdditionalCustomerEnrollBiometricRequestData(serviceOptions: UserDefaults.serviceOptions)
        IDentitySDK.customerEnrollBiometrics(from: instance, personalData: personalData, options: options) { result in
            switch result {
            case .success(let customerEnrollBiometricsResult):
                self.emptyResults()
                customerEnrollBiometricsResult2=customerEnrollBiometricsResult
                // pretty print the request object
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let _ = customerEnrollBiometricsResult2, var request = IDentitySDK.customerEnrollBiometricsRequest {
                    // stub out the base64 image text for logging
                    request.customerData.biometericData.selfie = "..."
                    let requestObfuscated = request
                  
                    if let data = try? encoder.encode(request),
                       let json = String(data: data, encoding: .utf8)  {
                        self.texts = json
                    } else {
                        self.texts = "ERROR"
                    }
                  
                    if let dataObfuscated = try? encoder.encode(requestObfuscated),
                       let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                        self.textObfuscated = jsonObfuscated
                    } else {
                        self.textObfuscated = "ERROR"
                    }
                }
                self.sendData(callbackId: callbackId, text: self.texts)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(callbackId: callbackId, text: error.localizedDescription)
            }
        }
    }

    // 105 - Customer Verification
    func startCustomerVerification(param: String, instance: UIViewController) {
        var uniqueNumber: String!
        var callbackId: String!
        do{
            if let json = param.data(using: String.Encoding.utf8){
                if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                    uniqueNumber = jsonData["uniqueNumber"] as? String
                    callbackId = jsonData["callbackId"] as? String
                }
            }
        }catch {
            print(error.localizedDescription)
        }
        let personalData = PersonalCustomerVerifyData(uniqueNumber: uniqueNumber)
        IDentitySDK.customerVerification(from: instance, personalData: personalData) { result in
            switch result {
            case .success(let customerVerificationResult):
                self.emptyResults()
                customerVerificationResult2=customerVerificationResult
                // pretty print the request object
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let _ = customerVerificationResult2, var request = IDentitySDK.customerVerifyRequest {
                    // stub out the base64 image text for logging
                    request.customerData.biometericData.selfie = "..."
                    let requestObfuscated = request
                  
                    if let data = try? encoder.encode(request),
                       let json = String(data: data, encoding: .utf8)  {
                        self.texts = json
                    } else {
                        self.texts = "ERROR"
                    }
                  
                    if let dataObfuscated = try? encoder.encode(requestObfuscated),
                       let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                        self.textObfuscated = jsonObfuscated
                    } else {
                        self.textObfuscated = "ERROR"
                    }
                }
                self.sendData(callbackId: callbackId, text: self.texts)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(callbackId: callbackId, text: error.localizedDescription)
            }
        }
    }

    
    // 185 - Identify Customer
    func startIdentifyCustomer(callbackId: String, instance: UIViewController) {
        IDentitySDK.identifyCustomer(from: instance) { result in
            switch result {
            case .success(let customerIdentifyResult):
                    self.emptyResults()
                    customerIdentifyResult2=customerIdentifyResult
                // pretty print the request object
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let _ = customerIdentifyResult2, var request = IDentitySDK.customerIdentifyRequest {
                    // stub out the base64 image text for logging
                    request.biometericData.selfie = "..."
                    let requestObfuscated = request
                  
                    if let data = try? encoder.encode(request),
                       let json = String(data: data, encoding: .utf8)  {
                        self.texts = json
                    } else {
                        self.texts = "ERROR"
                    }
                  
                    if let dataObfuscated = try? encoder.encode(requestObfuscated),
                       let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                        self.textObfuscated = jsonObfuscated
                    } else {
                        self.textObfuscated = "ERROR"
                    }
                }
                self.sendData(callbackId: callbackId, text: self.texts)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(callbackId: callbackId, text: error.localizedDescription)
            }
        }
    }

    // 660 - Live Face Check
    func startLiveFaceCheck(callbackId: String, instance: UIViewController) {
        // start selfie capture, presenting it from this view controller
        IDentitySDK.liveFaceCheck(from: instance) { result in
            switch result {
            case .success(let liveFaceCheckResult):
                    self.emptyResults()
                    liveFaceCheckResult2=liveFaceCheckResult
                // pretty print the request object
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                if let _ = liveFaceCheckResult2, var request = IDentitySDK.customerLiveCheckRequest {
                    // stub out the base64 image text for logging
                    request.customerData.biometericData.selfie = "..."
                    let requestObfuscated = request
                  
                    if let data = try? encoder.encode(request),
                       let json = String(data: data, encoding: .utf8)  {
                        self.texts = json
                    } else {
                        self.texts = "ERROR"
                    }
                  
                    if let dataObfuscated = try? encoder.encode(requestObfuscated),
                       let jsonObfuscated = String(data: dataObfuscated, encoding: .utf8)  {
                        self.textObfuscated = jsonObfuscated
                    } else {
                        self.textObfuscated = "ERROR"
                    }
                }
                self.sendData(callbackId: callbackId, text: self.texts)
            case .failure(let error):
                print(error.localizedDescription)
                self.sendData(callbackId: callbackId, text: error.localizedDescription)
            }
        }
    }
    func submitResult(callbackId: String, instance: UIViewController) {
      submit(callbackId: callbackId)
    }

    @objc func submit(callbackId: String) {
        var callbackId: String = callbackId
        if let validateIdResult = validateIdResult2 {
            validateIdResult.submit { result, hostData in
                self.navigationItem.leftBarButtonItem = nil
                validateIdResult2 = nil
                switch result {
                case .success(let response):
                    var hostDataString = ""
                    if let hostData = hostData,
                       let data = try? JSONSerialization.data(withJSONObject: hostData, options: [.prettyPrinted]),
                       let json = String(data: data, encoding: .utf8) {
                        hostDataString = "Host Data:\n\n" + json + "\n\n"
                    }

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        //self.texts = json + "\n\n\(hostDataString)- - -\n\n"
                        self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        } else if let validateIdMatchFaceResult = validateIdMatchFaceResult2 {
            validateIdMatchFaceResult.submit { result, hostData in
                self.navigationItem.leftBarButtonItem = nil
                validateIdMatchFaceResult2 = nil
                switch result {
                case .success(let response):
                    var hostDataString = ""
                    if let hostData = hostData,
                       let data = try? JSONSerialization.data(withJSONObject: hostData, options: [.prettyPrinted]),
                       let json = String(data: data, encoding: .utf8) {
                        hostDataString = "Host Data:\n\n" + json + "\n\n"
                    }

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                      //self.texts = json + "\n\n\(hostDataString)- - -\n\n"
                      self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        } else if let customerEnrollResult = customerEnrollResult2 {
            customerEnrollResult.submit { result, hostData in
                self.navigationItem.leftBarButtonItem = nil
                customerEnrollResult2 = nil
                switch result {
                case .success(let response):
                    var hostDataString = ""
                    if let hostData = hostData,
                       let data = try? JSONSerialization.data(withJSONObject: hostData, options: [.prettyPrinted]),
                       let json = String(data: data, encoding: .utf8) {
                        hostDataString = "Host Data:\n\n" + json + "\n\n"
                    }

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                      //self.texts = json + "\n\n\(hostDataString)- - -\n\n"
                      self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        } else if let customerEnrollBiometricsResult = customerEnrollBiometricsResult2 {
            customerEnrollBiometricsResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil
                customerEnrollBiometricsResult2 = nil
                switch result {
                case .success(let response):
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        } else if let customerVerificationResult = customerVerificationResult2 {
            customerVerificationResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil
                customerVerificationResult2 = nil
                switch result {
                case .success(var response):
                    // stub out the base64 image text for logging
                    response.responseCustomerVerifyData?.extractedPersonalData?.enrolledFaceImage = "..."

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        } else if let customerIdentifyResult = customerIdentifyResult2 {
            customerIdentifyResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil
                customerIdentifyResult2 = nil
                switch result {
                case .success(var response):
                    // stub out the base64 image text for logging
                    response.responseCustomerData?.extractedPersonalData?.enrolledFaceImage = "..."

                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        } else if let liveFaceCheckResult = liveFaceCheckResult2 {
            liveFaceCheckResult.submit { result in
                self.navigationItem.leftBarButtonItem = nil
                liveFaceCheckResult2 = nil
                switch result {
                case .success(let response):
                    let encoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    if let data = try? encoder.encode(response), let json = String(data: data, encoding: .utf8) {
                        self.texts = json
                    }
                    self.sendData(callbackId: callbackId)
                case .failure(let error):
                    self.texts = error.localizedDescription
                    self.sendData(callbackId: callbackId)
                }
            }
        }
    }
    
    private func sendData(callbackId: String) {
      let dict2:NSMutableDictionary? = ["data" : self.texts ?? ["data" : "error"]]
      let iDMissionSDK = IDMissionSDK_Cordova_Plugin()
      iDMissionSDK.sendResponse(to: callbackId, with: dict2)
    }
    
    private func sendData(callbackId: String, text: String) {
      let dict2:NSMutableDictionary? = ["data" : text ]
      let iDMissionSDK = IDMissionSDK_Cordova_Plugin()
      iDMissionSDK.sendResponse(to: callbackId, with: dict2)
    }
    
    func emptyResults(){
      validateIdResult2 = nil
      validateIdMatchFaceResult2 = nil
      customerEnrollResult2 = nil
      customerEnrollBiometricsResult2 = nil
      customerVerificationResult2 = nil
      customerIdentifyResult2 = nil
      liveFaceCheckResult2 = nil
    }
}
