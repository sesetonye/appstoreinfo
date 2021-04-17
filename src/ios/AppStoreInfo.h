#import <Cordova/CDVPlugin.h>

@interface AppStoreInfo : CDVPlugin 
- (void)coolMethod:(CDVInvokedUrlCommand*)command;

- (void)appInfo:(CDVInvokedUrlCommand*)command;

@end
