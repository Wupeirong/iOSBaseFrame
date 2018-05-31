//
//  FSBaseViewModel.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBaseViewModel : NSObject


/// A RACSubject object, which representing all errors occurred in view model.
@property (nonatomic, readonly, strong) RACSubject *errors;

@property (nonatomic, strong) UIView *parentView;

/// sub class can override
- (void)initialize;


@end
