//
//  FSBannerView.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseView.h"
#import "FSHomeViewModel.h"
#import "FSMovieModel.h"

typedef void (^DataCallback) (id responseOject);

@interface FSBannerView : FSBaseView

@property (nonatomic, strong) FSHomeViewModel *homeVM;

@property (nonatomic, copy) DataCallback callback;



@end
