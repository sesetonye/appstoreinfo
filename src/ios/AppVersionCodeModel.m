#import "AppVersionCodeModel.h"

@implementation AppVersionCodeModel

-(id) initWithStoreVersion:(int) storeVersion andLocalVersion: (int) localVersion{
    self = [super init];
    if (self){
        self.storeVersion = storeVersion;
        self.localVersion = localVersion;
    }
    return self;
}

@end