//
//  AppDelegate+Extension.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/20.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "AppDelegate+Extension.h"
#import "MBProgressHUD+FSExtension.h"
#import "CYLTabBarControllerConfig.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@implementation AppDelegate (Extension)

- (void)initWindow {

    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    self.window.backgroundColor = FSWhiteColor;
     [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = FSWhiteColor;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
}

#pragma mark 初始化网络配置
- (void)monitorNetworkStatus {
    [FSNetworkHelper networkStatusWithBlock:^(FSNetworkStatusType status) {
        switch (status) {
            case FSNetworkStatusUnknown:
                DLog(@"网络环境：未知网络");
                
                break;
            
            case FSNetworkStatusNotReachable:
                DLog(@"网络环境：无网络");
                [MBProgressHUD showMessage:@"网络状态不佳，请检查网络" onView:FSAppWindow];
                break;
            
            case FSNetworkStatusReachableViaWWAN:
                DLog(@"网络环境：手机自带网络");
                
                break;
            
            case FSNetworkStatusReachableViaWiFi:
                DLog(@"网络环境：WIFI");
                
                break;
                
            default:
                break;
        }
    }];
}

@end
