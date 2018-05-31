//
//  UtilsMacros.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/20.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h


#define FSAppWindow                          [[[UIApplication sharedApplication] delegate] window]
#define FSRootViewController                 FSAppWindow.rootViewController
//状态栏高度
#define FSStatusBarHeight                    [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define FSNavBarHeight                       (44.0)
//底部TabBar高度
#define FSTabBarHeight                       (FSStatusBarHeight > 20 ? (83) : (49))
//顶部导航+状态栏高度
#define FSTopHeight                          (FSStatusBarHeight + FSNavBarHeight)
//屏幕宽度
#define FSScreenWidth                        ([[UIScreen mainScreen] bounds].size.width)
//屏幕高度
#define FSScreenHeight                       ([[UIScreen mainScreen] bounds].size.height)

#define FSScreenBounds                       [[UIScreen mainScreen] bounds]
//view宽度
#define FSViewWidth(view)                    (view.frame.size.width)
//view高度
#define FSViewHeigth(view)                   (view.frame.size.height)

#define IPhone6ScaleWidth                    (FSScreenWidth / 375.0)
#define IPhone6ScaleHeight                   (FSScreenHeight / 667.0)

//与屏幕宽度比为9/16的高度
#define Height9To16                           ((9.0/16.0) * FSScreenWidth)

#define FSRealValue(width)                   ((width) * (FSScreenWidth / 375.0))
//弱引用
#define FSWeakSelf(type)                     __weak typeof(type) weak##type = type;
#define FSStrongSelf(type)                   __strong typeof(type) type = weak##type;

//View圆角
#define FSViewRadius(view, radius)\
\
[view.layer setCornerRadius:radius];\
[view.layer setMasksToBounds:YES];

//View圆角+边框
#define FSViewBorderRadius(view, radius, borderWidth, color)\
[view.layer setCornerRadius:radius];\
[view.layer setMasksToBounds:YES];\
[view.layer setBorderWidth:borderWidth];\
[view.layer setBorderColor:[color CGColor]];

//当前系统版本
#define CurrentSystemVersion                [[[UIDevice currentDevice] systemVersion] doubleValue]

//-------------------打印日志-------------------------
//DEBUG 模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//UIImage对象
#define FSImageWithName(name)                       [UIImage imageName:name]


#endif /* UtilsMacros_h */
