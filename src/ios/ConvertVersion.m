#import "ConvertVersion.h"

@implementation ConvertVersion

-(int) numberToCode:(NSString *) versionNumber{
    if (versionNumber == (id)[NSNull null] || versionNumber.length == 0 ){
        return 0;
    }
    NSArray *versionArray = [versionNumber componentsSeparatedByString:@"."];
    int versionCode = 1000 * versionArray[0] + 100 * versionArray[1] + versionArray[2] ;
    return versionCode;
}

@end