#import <Foundation/Foundation.h>

@interface AppVersionCodeModel : NSObject

@property (assign) int storeVersion;
@property (assign) int localVersion;

-(id) initWithStoreVersion:(int) storeVersion andLocalVersion: (int) localVersion;

@end