/********* AppStoreInfo.m Cordova Plugin Implementation *******/
#import "AppStoreInfo.h"
#import "AppVersionCodeModel.h"
#import "ConvertVersion.h"
// #import <Cordova/CDV.h>


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
          NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", appID]];
          NSData* data = [NSData dataWithContentsOfURL:url];
          NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
          NSString* appStoreVersion = NULL;
          AppVersionCodeModel *model = [[AppVersionCodeModel alloc] initWithStoreVersion: 0 andLocalVersion: 0];
    
    NSMutableDictionary *response = [[NSMutableDictionary alloc] initWithCapacity:2];
        

          if ([lookup[@"resultCount"] integerValue] == 1){

              ConvertVersion *convert = [[ConvertVersion alloc] init];

              appStoreVersion = lookup[@"results"][0][@"version"];
              NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];

              int appStoreVersionCode = [convert numberToCode: appStoreVersion];
              int localVersionCode = [convert numberToCode: currentVersion];

              model = [[AppVersionCodeModel alloc] initWithStoreVersion: appStoreVersionCode andLocalVersion: localVersionCode];

              [response setObject:[NSNumber numberWithInt:appStoreVersionCode] forKey: @"storeVersion"];
              [response setObject:[NSNumber numberWithInt:localVersionCode] forKey: @"localVersion"];
              
              NSLog(@"App Version = [%@]", appStoreVersion);
          }else{
              [response setObject:[NSNumber numberWithInt:0] forKey: @"storeVersion"];
              [response setObject:[NSNumber numberWithInt:0] forKey: @"localVersion"];
              
            appStoreVersion = @"FALSE";
          }
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:response];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


@end
