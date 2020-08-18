//
//  NetworkService.m
//  BasicTools
//
//  Created by pengchao yan on 2020/8/4.
//

#import "NetworkService.h"
#import "TMReachability.h"
#import "HLNetWorkReachability.h"

@interface NetworkService ()

@property (nonatomic, strong) TMReachability *tmReachability;
@property (nonatomic, strong) HLNetWorkReachability *hlReachability;
@property (atomic, assign) BOOL tmInMonitor;
@property (atomic, assign) BOOL hlInMonitor;

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

+ (instancetype)micromeshShareInstance {
    static NetworkService *sInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[NetworkService alloc] init];
        sInstance.hlReachability = [HLNetWorkReachability reachabilityWithHostName:@"https://www.baidu.com"];
    });
    
    return sInstance;
}

- (void)startMonitor {
    @synchronized (self.tmReachability) {
        if (self.tmReachability != nil) {
            if (!self.tmInMonitor) {
                self.tmInMonitor = YES;
                
                __weak typeof(self) weakSelf = self;
                _tmReachability.reachableBlock = ^(TMReachability* reach) {
                    [weakSelf updateCurrentStatusWithTMReachability:reach];
                };

                _tmReachability.unreachableBlock = ^(TMReachability *reach) {
                    [weakSelf updateCurrentStatusWithTMReachability:reach];
                };
                
                [_tmReachability startNotifier];
            }
        }
    }
    
    @synchronized (self.hlReachability) {
        if (self.hlReachability != nil) {
            if (!self.hlInMonitor) {
                self.hlInMonitor = YES;
                
                [[NSNotificationCenter defaultCenter] addObserver:self
                                                         selector:@selector(reachabilityChanged:)
                                                             name:kNetWorkReachabilityChangedNotification object:nil];
                [_hlReachability startNotifier];
            }
        }
    }
}

- (void)updateCurrentStatusWithTMReachability:(TMReachability *)reach {
    switch (reach.currentReachabilityStatus) {
        case NotReachable:
            self.networkStatus = eNetworkStatusNotReachable;
            break;
        case ReachableViaWiFi:
            self.networkStatus = eNetworkStatusWifi;
            break;
        case ReachableViaWWAN:
            self.networkStatus = eNetworkStatusMobileNetwork;
            break;
        default:
            self.networkStatus = eNetworkStatusUnkown;
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BTNetworkStatusChangedNotification object:@(self.networkStatus)];
}

- (void)reachabilityChanged:(NSNotification *)notification {
    HLNetWorkReachability *curReach = [notification object];
    HLNetWorkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus) {
        case HLNetWorkStatusNotReachable:
            self.networkStatus = eNetworkStatusNotReachable;
            break;
        case HLNetWorkStatusUnknown:
            self.networkStatus = eNetworkStatusUnkown;
            break;
        case HLNetWorkStatusWWAN2G:
            self.networkStatus = eNetworkStatus2G;
            break;
        case HLNetWorkStatusWWAN3G:
            self.networkStatus = eNetworkStatus3G;
            break;
        case HLNetWorkStatusWWAN4G:
            self.networkStatus = eNetworkStatus4G;
            break;
        case HLNetWorkStatusWiFi:
            self.networkStatus = eNetworkStatusWifi;
            break;
        default:
            self.networkStatus = eNetworkStatusUnkown;
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BTNetworkStatusChangedNotification object:@(self.networkStatus)];
}

+ (NSString *)descriptionForNetworkStatus:(ENetworkStatus)networkStatus {
    switch (networkStatus) {
        case eNetworkStatusNotReachable:
            return @"无网络";
        case eNetworkStatusUnkown:
            return @"未知网络";
        case eNetworkStatus2G:
            return @"2G";
            break;
        case eNetworkStatus3G:
            return @"3G";
            break;
        case eNetworkStatus4G:
            return @"4G";
        case eNetworkStatusWifi:
            return @"WIFI";
        default:
            return @"未知网络";
            break;
    }
}

@end
