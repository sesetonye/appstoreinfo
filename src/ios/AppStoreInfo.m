/********* AppStoreInfo.m Cordova Plugin Implementation *******/
#import "AppUpdate.h"
#import "AppVersionCodeModel.h"
#import "ConvertVersion.h"
#import <Cordova/CDV.h>


@implementation AppStoreInfo

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)appInfo:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = nil;
     NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
          //NSString* appID = infoDictionary[@"CFBundleIdentifier"];
           NSString* appID = @"1516965769";
          NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
          NSData* data = [NSData dataWithContentsOfURL:url];
          NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
          NSString* appStoreVersion = NULL;
          AppVersionCodeModel *model = [[AppVersionCodeModel alloc] initWithStoreVersion: 0 andLocalVersion: 0];

          if ([lookup[@"resultCount"] integerValue] == 1){

              ConvertVersion *convert = [[ConvertVersion alloc] init];

              appStoreVersion = lookup[@"results"][0][@"version"];
              NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];

              int appStoreVersionCode = [convert numberToCode: appStoreVersion];
              int localVersionCode = [convert numberToCode: currentVersion];

              model = [[AppVersionCodeModel alloc] initWithStoreVersion: appStoreVersionCode andLocalVersion: localVersionCode];

              NSLog(@"App Version = [%@]", appStoreVersion);
          }else{
            appStoreVersion = @"FALSE";
          }
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:model];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
