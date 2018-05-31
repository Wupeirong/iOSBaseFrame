//
//  Observe_RAC.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observe_RAC : NSObject

typedef void (^Observe_rac_change)(id x);

typedef void (^Observe_rac_notify)(NSNotification *notification);

+ (void)observe:(id)obj key:(NSString *)property block:(Observe_rac_change)block;

+ (void)addNotify:(NSString *)notify block:(Observe_rac_notify)block;

+ (void)addNotify:(NSString *)notify dealloc:(id)dealloc block:(Observe_rac_notify)block;

@end
