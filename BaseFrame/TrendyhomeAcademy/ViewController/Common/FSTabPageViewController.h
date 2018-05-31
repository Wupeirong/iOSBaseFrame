//
//  FSTabPageViewController.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <YPTabBarController/YPTabBarController.h>
#import <ReactiveObjC/ReactiveObjC.h>

@protocol PageScrollDelegate<NSObject>

@property (nonatomic, readonly) UIScrollView *scrollView;

@end


@interface FSTabPageViewController : YPTabBarController

- (RACSignal *)contentScrollSignal;

@end
