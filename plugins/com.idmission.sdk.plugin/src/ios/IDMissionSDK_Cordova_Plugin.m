/********* IDMissionSDK_Cordova_Plugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "MainViewController.h"
#import "IDMissionSDK_Cordova_Plugin.h"
#import "IDMissionSDK_Cordova_Client-Swift.h"

#pragma mark - IDMissionSDK Cordova Plugin Interface

#pragma mark - IDMission Cordova Plugin Implementation

@implementation IDMissionSDK_Cordova_Plugin

static IDMissionSDK_Cordova_Plugin *gInstance = NULL;
NSMutableDictionary *processConfig;

#pragma mark - Initialize Labels

+ (void)initialize {
    processConfig = [NSMutableDictionary new];
}

#pragma mark - Cordova Methods

- (void)sendResponseTo:(NSString *)callbackId withObject:(id)obj {
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
    [gInstance.commandDelegate sendPluginResult:result callbackId:callbackId];
}
    
- (void)idm_sdk_init:(CDVInvokedUrlCommand*)command
{
    gInstance = self;
    NSString *scanCallbackId = command.callbackId;
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client initializeSDKWithCallbackId:scanCallbackId];
}

- (void)idm_sdk_serviceID20:(CDVInvokedUrlCommand*)command
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *scanCallbackId = command.callbackId;
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startIDValidationsWithCallbackId:scanCallbackId instances:rootViewController];
}

- (void)idm_sdk_serviceID10:(CDVInvokedUrlCommand*)command
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *scanCallbackId = command.callbackId;
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startIDValidationAndMatchFacesWithCallbackId:scanCallbackId instances:rootViewController];
}

- (void)idm_sdk_serviceID50:(CDVInvokedUrlCommand*)command
{
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    NSString *uniqueNumber = [commandJson objectForKey:@"uniqueNumber"];    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *callbackId = command.callbackId;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:uniqueNumber forKey:@"uniqueNumber"];
    [dict setValue:callbackId forKey:@"callbackId"];
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *params = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startIDValidationAndCustomerEnrollsWithParams:params instances:rootViewController];
}

- (void)idm_sdk_serviceID175:(CDVInvokedUrlCommand*)command
{
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    NSString *uniqueNumber = [commandJson objectForKey:@"uniqueNumber"];    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *callbackId = command.callbackId;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:uniqueNumber forKey:@"uniqueNumber"];
    [dict setValue:callbackId forKey:@"callbackId"];
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *params = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startCustomerEnrollBiometricssWithParams:params instances:rootViewController];
}

- (void)idm_sdk_serviceID105:(CDVInvokedUrlCommand*)command 
{
    NSString* commandJsonString = [command.arguments objectAtIndex:0];
    NSData *commandData = [commandJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *commandJson = [NSJSONSerialization JSONObjectWithData:commandData options:0 error:nil];
    NSString *uniqueNumber = [commandJson objectForKey:@"uniqueNumber"];    
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *callbackId = command.callbackId;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:uniqueNumber forKey:@"uniqueNumber"];
    [dict setValue:callbackId forKey:@"callbackId"];
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *params = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startCustomerVerificationsWithParams:params instances:rootViewController];
}

- (void)idm_sdk_serviceID185:(CDVInvokedUrlCommand*)command
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *scanCallbackId = command.callbackId;
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startIdentifyCustomersWithCallbackId:scanCallbackId instances:rootViewController];
}

- (void)idm_sdk_serviceID660:(CDVInvokedUrlCommand*)command
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *scanCallbackId = command.callbackId;
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client startLiveFaceChecksWithCallbackId:scanCallbackId instances:rootViewController];
}

- (void)idm_sdk_submitResult:(CDVInvokedUrlCommand*)command
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    NSString *scanCallbackId = command.callbackId;
    IDentitySDKHelper *client = [IDentitySDKHelper new];
    [client submitResultsWithCallbackId:scanCallbackId instances:rootViewController];
}

@end
