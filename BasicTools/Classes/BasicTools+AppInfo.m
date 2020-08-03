//
//  BasicTools+AppInfo.m
//  BasicTools
//
//  Created by pengchao yan on 2020/8/3.
//

#import "BasicTools+AppInfo.h"

@implementation BasicTools (AppInfo)

+ (NSString *)appId {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appFullVersion {
    NSString *mainVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"%@.%@", mainVersion, buildVersion];
}

@end
