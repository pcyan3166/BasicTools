//
//  NetworkService.m
//  BasicTools
//
//  Created by pengchao yan on 2020/8/4.
//

#import "NetworkService.h"
#import "TMReachability.h"

@interface NetworkService ()

@property (nonatomic, strong) TMReachability *tmReachability;
@property (atomic, assign) BOOL inMonitor;

@end

@implementation NetworkService

+ (instancetype)shareInstance {
    static NetworkService *sInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[NetworkService alloc] init];
        sInstance.tmReachability = [TMReachability reachabilityWithHostname:@"https://www.baidu.com"];
    });
    
    return sInstance;
}

- (void)startMonitor {
    @synchronized (self.tmReachability) {
        if (!self.inMonitor) {
            self.inMonitor = YES;
            
            _tmReachability.reachableBlock = ^(TMReachability* reach) {
                [[NSNotificationCenter defaultCenter] postNotificationName:BTNetworkStatusChangedNotification object:reach];
            };

            _tmReachability.unreachableBlock = ^(TMReachability *reach) {
                [[NSNotificationCenter defaultCenter] postNotificationName:BTNetworkStatusChangedNotification object:reach];
            };
            
            [_tmReachability startNotifier];
        }
    }
}

- (NSString *)currentStatus {
    switch (self.tmReachability.currentReachabilityStatus) {
        case NotReachable:
            return @"无网络";
            break;
        case ReachableViaWiFi:
            return @"WIFI";
            break;
        case ReachableViaWWAN:
            return @"移动网络";
            break;
        default:
            break;
    }
    
    return @"未知网络状态";
}

@end
