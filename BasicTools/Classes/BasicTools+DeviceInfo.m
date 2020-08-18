//
//  BasicTools+DeviceInfo.m
//  BasicTools
//
//  Created by pengchao yan on 2020/8/3.
//

#import "BasicTools+DeviceInfo.h"
#import "NetworkService.h"
#import "BasicTools+AppInfo.h"
#import <SAMKeychain/SAMKeychain.h>
#import "sys/utsname.h"

@implementation BasicTools (DeviceInfo)

+ (NSString *)osType {
    return @"iOS";
}

+ (NSString *)osVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)deviceBrand {
    return @"Apple";
}

+ (NSString *)deviceType {
    static NSString *deviceType = nil;
    if (deviceType == nil) {
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *deviceOriginalStr = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [bundle pathForResource:@"BasicTools" ofType:@"bundle"];
        bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *filePath = [bundle pathForResource:@"iOSDeviceTypeInfo" ofType:@"plist"];
        NSDictionary *allDeviceInfoDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        deviceType = allDeviceInfoDic[deviceOriginalStr];
    }
    
    return deviceType;
}

+ (NSString *)networkType {
    return [NetworkService descriptionForNetworkStatus:[NetworkService shareInstance].networkStatus];
}

+ (NSString *)deviceId {
    static NSString *deviceId = nil;
    if (deviceId == nil) {
        deviceId = [SAMKeychain passwordForService:[BasicTools appId] account:@"deviceId"];
        if ([deviceId length] <= 0) {
            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
            deviceId = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
            CFRelease(uuidRef);
            
            [SAMKeychain setPassword:deviceId forService:[BasicTools appId] account:@"deviceId"];
        }
    }
    
    return deviceId;
}

+ (NSString *)resetDeviceId {
    CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
    NSString *deviceId = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
    CFRelease(uuidRef);
    
    [SAMKeychain setPassword:deviceId forService:[BasicTools appId] account:@"deviceId"];
    
    return deviceId;
}

@end
