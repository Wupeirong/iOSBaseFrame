//
//  FSHomeModel.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSHomeModel.h"


@implementation FSHomeModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data":@"FSMovieModel"
             };
}

- (NSString *)description {
    return [NSString stringWithFormat:@"FSHomeModel:%@", _name];
}

@end
