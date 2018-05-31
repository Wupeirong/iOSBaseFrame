//
//  FSReactiveView.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/5/2.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSReactiveView <NSObject>

/// viewModel - The view model
- (void)bindViewModel:(id)viewModel;

@end
