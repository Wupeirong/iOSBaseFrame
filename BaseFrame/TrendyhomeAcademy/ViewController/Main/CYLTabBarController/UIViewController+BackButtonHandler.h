//
//  UIViewController+BackButtonHandler.h
//  Fashion+
//
//  Created by Fashion+ on 2017/6/1.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
-(BOOL)navigationShouldPopOnBackButton;
@end


@interface UIViewController (BackButtonHandler)<BackButtonHandlerProtocol>

@end
