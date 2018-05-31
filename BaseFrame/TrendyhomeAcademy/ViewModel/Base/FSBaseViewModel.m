//
//  FSBaseViewModel.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewModel.h"

@interface FSBaseViewModel()

/// A RACSubject object, which representing all errors occurred in view model.
@property (nonatomic, readwrite, strong) RACSubject *errors;

@end

@implementation FSBaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    FSBaseViewModel *viewModel = [super allocWithZone:zone];
    [viewModel initialize];
    
    return viewModel;
}

/// sub class can override
- (void)initialize {}

- (RACSubject *)errors {
    if (!_errors) _errors = [RACSubject subject];
    return _errors;
}


@end
