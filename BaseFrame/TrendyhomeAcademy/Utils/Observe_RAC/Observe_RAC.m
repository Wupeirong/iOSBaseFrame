//
//  Observe_RAC.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "Observe_RAC.h"

@implementation Observe_RAC

+ (void)observe:(id)obj key:(NSString *)property block:(Observe_rac_change)block {
    [[obj rac_valuesForKeyPath:property observer:nil] subscribeNext:^(id  _Nullable x) {
        if (block) {
            block(x);
        }
    }];
}


+ (void)addNotify:(NSString *)notify block:(Observe_rac_notify)block {
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:notify object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(NSNotification * _Nullable x) {
        if (block) {
            block(x);
        }
    }];
}

+ (void)addNotify:(NSString *)notify dealloc:(id)dealloc block:(Observe_rac_notify)block {
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:notify object:nil] takeUntil:[dealloc rac_willDeallocSignal]] subscribeNext:^(NSNotification * _Nullable x) {
        if (block) {
            block(x);
        }
    }];
}





@end
