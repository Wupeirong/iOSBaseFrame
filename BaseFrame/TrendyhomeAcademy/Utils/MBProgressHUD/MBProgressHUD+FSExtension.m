//
//  MBProgressHUD+FSExtension.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/20.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "MBProgressHUD+FSExtension.h"

@implementation MBProgressHUD (FSExtension)

+ (void)showMessage:(NSString *)msg onView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:2];
}

@end
