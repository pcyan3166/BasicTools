//
//  PCViewController.m
//  BasicTools
//
//  Created by pcyan on 08/03/2020.
//  Copyright (c) 2020 pcyan. All rights reserved.
//

#import "PCViewController.h"
#import <BasicTools/BasicTools.h>
#import <BasicTools/BasicTools+AppInfo.h>
#import <BasicTools/BasicTools+DeviceInfo.h>
#import <BasicTools/NetworkService.h>

@interface PCViewController ()

@end

@implementation PCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"appId is %@", [BasicTools appId]);
    NSLog(@"appVersion is %@", [BasicTools appVersion]);
    NSLog(@"appFullVersion is %@", [BasicTools appFullVersion]);
    NSLog(@"osType is %@", [BasicTools osType]);
    NSLog(@"osVersion is %@", [BasicTools osVersion]);
    NSLog(@"deviceBrand is %@", [BasicTools deviceBrand]);
    NSLog(@"deviceType is %@", [BasicTools deviceType]);
    NSLog(@"networkType is %@", [BasicTools networkType]);
    NSLog(@"deviceId is %@", [BasicTools deviceId]);
    NSLog(@"resetDeviceId is %@", [BasicTools resetDeviceId]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
