//
//  IDMissionSDK_Cordova_Plugin.h
//  IDMissionSDK_Cordova_Client
//
//  Created by Pranjal Lamba on 09/12/21.
//

#import <UIKit/UIKit.h>
#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>

@interface IDMissionSDK_Cordova_Plugin : CDVPlugin{

}

@property (nonatomic, copy, readwrite) NSString *scanCallbackId;
- (void)sendResponseTo:(NSString *)callbackId withObject:(id)objwithObject; + (void)initialize;
- (void)idm_sdk_init:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID20:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID10:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID50:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID175:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID105:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID185:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_serviceID660:(CDVInvokedUrlCommand*)command;
- (void)idm_sdk_submitResult:(CDVInvokedUrlCommand*)command;

@end
