//
//  FSTableViewModel.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/26.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSTableViewModel.h"

@interface FSTableViewModel()

@property (nonatomic, readwrite, strong) RACCommand *requestRemoteDataCommand;

@end

@implementation FSTableViewModel

- (void)initialize {
    [super initialize];
    
    self.page = 1;
    self.pageSize = 3;
    
//    FSWeakSelf(self)
//    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *page) {
//        FSStrongSelf(self)
////        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
//        return [self requestRemoteDataSignalWithPage:page.unsignedIntegerValue];
//    }];
//
//    [[self.requestRemoteDataCommand.errors filter:[self requestRemoteDataErrorsFilter]] subscribe:self.errors];
}

/// sub class can ovrride it
//- (BOOL (^)(NSError *error))requestRemoteDataErrorsFilter {
//    return ^(NSError *error) {
//        return YES;
//    };
//}

//- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
//    return [RACSignal empty];
//}


- (void)requestDataWithPage:(NSUInteger)page success:(FSRequestSuccess)success failure:(FSRequestFailed)failure {}


- (NSString *)description {
    return [NSString stringWithFormat:@"dataSource:%@", self.dataSource];
}

@end
