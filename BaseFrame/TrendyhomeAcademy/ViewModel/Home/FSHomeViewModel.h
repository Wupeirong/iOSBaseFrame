//
//  FSHomeViewModel.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewModel.h"

@interface FSHomeViewModel : FSBaseViewModel

@property (nonatomic, strong) id rac_resObj;

@property (nonatomic, readwrite, strong) RACCommand *didSelectCommand;


- (void)requestHomeData:(FSRequestSuccess)success failure:(FSRequestFailed)failure ;


@end
