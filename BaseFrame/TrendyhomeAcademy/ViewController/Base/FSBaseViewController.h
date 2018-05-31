//
//  FSBaseViewController.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/21.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSBaseViewModel.h"


@interface FSBaseViewController : UIViewController

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

@property (nonatomic, strong, readonly) FSBaseViewModel *viewModel;

- (instancetype)initWithViewModel:(FSBaseViewModel *)viewModel;


@end
