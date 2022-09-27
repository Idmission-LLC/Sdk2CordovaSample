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

//
//  MainViewController.h
//  IDMissionSDK_Cordova_Client
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
//#import "IDMissionSDK_Cordova_Client-Swift.h"

//@interface UIViewController ()
//
//@end

@implementation MainViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.launchView setAlpha:1];
}

#pragma mark - IDMission SDK Methods
//IDmission SDK Methods - Start
- (void)sendResponseTo:(NSString *)callbackId withObject:(id)obj {
    NSMutableDictionary *filteredResp = [NSMutableDictionary dictionary];
    [filteredResp setValue:@"000" forKey:@"StatusCode"];
    [filteredResp setValue:obj forKey:@"Message"];
    obj = filteredResp;
    
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
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[obj
                                                                                     intValue]];
    } else if(!obj) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK]; } else {
            NSLog(@"Success callback wrapper not yet implemented for class %@", [obj class]); }
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

//NSLog(@"IDMissionSDK_Cordova_Client sendResponseTo");
//CDVPluginResult *result = nil;
//    NSData *data = [@"obj" dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
//
//[gInstance.commandDelegate sendPluginResult:result callbackId:callbackId];

//#pragma mark - SDK response Method
//
//- (void)initializeSDKResponse:(NSString *)result {
//    NSLog(@"initializeSDKResponse");
//    [self sendResponseTo:self.scanCallbackId withObject:result];
//}
//
//- (void)captureImageResponse:(NSMutableDictionary *)result {
//    NSLog(@"captureImageResponse");
//    [self sendResponseTo:self.scanCallbackId withObject:result];
//}
//
//- (void)faceDetectionResponse:(NSMutableDictionary *)result {
//    NSLog(@"faceDetectionResponse");
//    NSMutableDictionary *filteredResp = [NSMutableDictionary dictionary];
//    [filteredResp setValue:[result objectForKey:@"statusCode"] forKey:@"statusCode"];
//    [filteredResp setValue:[result objectForKey:@"StatusCode"] forKey:@"StatusCode"];
//    [filteredResp setValue:[result objectForKey:@"FACE"] forKey:@"FACE"];
//    [self sendResponseTo:self.scanCallbackId withObject:filteredResp];
//}
//
//- (void)captureSignatureResponse:(NSMutableDictionary *)result {
//    NSLog(@"captureSignatureResponse");
//    NSMutableDictionary *filteredResp = [NSMutableDictionary dictionary];
//    [filteredResp setValue:[result objectForKey:@"statusCode"] forKey:@"statusCode"];
//    [filteredResp setValue:[result objectForKey:@"StatusCode"] forKey:@"StatusCode"];
//    [filteredResp setValue:[result objectForKey:@"signatureImage"] forKey:@"SIGNATURE"];
//    [self sendResponseTo:self.scanCallbackId withObject:result];
//}
//
//- (void)videoRecordingResponse:(NSMutableDictionary *)result {
//    NSLog(@"videoRecordingResponse");
//    if ([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
//        NSString *filteredResp = [NSString stringWithFormat:@"{\"statusCode\" :\"%@\",\"RECORDING\" : \"%@\"}",[result objectForKey:@"statusCode"],[result objectForKey:@"VIDEO_DATA"]];
//        [self sendResponseTo:self.scanCallbackId withObject:filteredResp];
//    } else {
//        [self sendResponseTo:self.scanCallbackId withObject:result];
//    }
//}
//
//- (void)voiceRecordingResponse:(NSMutableDictionary *)result {
//    NSLog(@"voiceCaptureResponse");
//    if ([[result objectForKey:@"statusCode"] isEqualToString:@"0"]) {
//        NSString *filteredResp = [NSString stringWithFormat:@"{\"statusCode\" :\"%@\",\"RECORDING\" : \"%@\"}",[result objectForKey:@"statusCode"],[result objectForKey:@"VOICE_DATA"]];
//        [self sendResponseTo:self.scanCallbackId withObject:filteredResp];
//    } else {
//        [self sendResponseTo:self.scanCallbackId withObject:result];
//    }
//}
//
//- (void)genericDocumentResponse:(NSMutableDictionary *)result {
//    NSLog(@"documentCaptureResponse");
//    NSMutableDictionary *filteredResp = [NSMutableDictionary dictionary];
//    [filteredResp setValue:[result objectForKey:@"statusCode"] forKey:@"statusCode"];
//    [filteredResp setValue:[result objectForKey:@"StatusCode"] forKey:@"StatusCode"];
//    [self sendResponseTo:self.scanCallbackId withObject:result];
//}
//
//- (void)processImageAndFaceMatchingResponse:(NSMutableDictionary *)result { NSLog(@"initializeSDKResponse");
//    [self sendResponseTo:self.scanCallbackId withObject:result];
//}
//
//- (void)genericApiCallResponse:(NSMutableDictionary *)result { NSLog(@"genericAppiCallResponse");
//    [self sendResponseTo:self.scanCallbackId withObject:result];
//}
//
//- (void)bankStatementDetectionResponse:(NSMutableDictionary *)result { }
//- (void)birthCertificateDetectionResponse:(NSMutableDictionary *)result { }
//- (void)cardDetectionResponse:(NSMutableDictionary *)result { }
//- (void)completeOperationResponse:(NSMutableDictionary *)result { }
//- (void)createEmployeeResponse:(NSMutableDictionary *)result { }
//- (void)executeGenericResponse:(NSMutableDictionary *)result { }
//- (void)faceMatchingResponse:(NSMutableDictionary *)result { }
//- (void)fingerprintEnrolmentResponse:(NSMutableDictionary *)result { }
//- (void)fingerprintVerificationResponse:(NSMutableDictionary *)result { }
//- (void)fourFingerprintDetectionResponse:(NSMutableDictionary *)result { }
//- (void)generateOTPResponse:(NSMutableDictionary *)result { }
//- (void)generateTokenResponse:(NSMutableDictionary *)result { }
//- (void)gpsCoordinateResponse:(NSMutableDictionary *)result { }
//- (void)idValidationAndVideoMatchingResponse:(NSMutableDictionary *)result { }
//- (void)processImageResponse:(NSMutableDictionary *)result { }
//- (void)proofOfAddressDetectionResponse:(NSMutableDictionary *)result { }
//- (void)scanBarcodeResponse:(NSMutableDictionary *)result { }
//- (void)snippetCaptureResponse:(NSMutableDictionary *)result { }
//- (void)updateCustomerResponse:(NSMutableDictionary *)result { }
//- (void)updateEmployeeResponse:(NSMutableDictionary *)result { }
//- (void)updateGenericResponse:(NSMutableDictionary *)result { }
//- (void)verifyCustomerResponse:(NSMutableDictionary *)result { }
//- (void)verifyEmployeeResponse:(NSMutableDictionary *)result { }
//- (void)verifyOTPResponse:(NSMutableDictionary *)result { }
//- (void)verifyPOAResponse:(NSMutableDictionary *)result { }
//- (void)verifyTokenResponse:(NSMutableDictionary *)result { }
@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
 in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
 in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
