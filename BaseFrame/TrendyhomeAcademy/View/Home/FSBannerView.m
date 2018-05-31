//
//  FSBannerView.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBannerView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "FSHomeModel.h"

@interface FSBannerView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerCycleView;



@end

@implementation FSBannerView

- (SDCycleScrollView *)bannerCycleView {
    if (!_bannerCycleView) {
        _bannerCycleView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
        _bannerCycleView.showPageControl = YES;
        _bannerCycleView.currentPageDotColor = [UIColor whiteColor];
        
    }
    
    return _bannerCycleView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bannerCycleView];
        [self bindModelView];
    }
    
    return self;
}

- (void)bindModelView {
    self.homeVM = [[FSHomeViewModel alloc] init];
    self.homeVM.parentView = self;
    [self.homeVM requestHomeData:nil failure:nil];
    
    FSWeakSelf(self)
    [Observe_RAC observe:self.homeVM key:@"rac_resObj" block:^(id rac_responseObject) {
        FSStrongSelf(self)
        if (rac_responseObject) {
            NSArray *data = (NSArray *)rac_responseObject;
            if (data.count > 0) {
                if (self.callback) {
                    self.callback(data);
                }
                FSHomeModel *model = data[0];
                NSMutableArray *images = [[NSMutableArray alloc] init];
                for (int i = 0; i < model.data.count; i++) {
                    FSMovieModel *mmodel = model.data[i];
                    NSString *imageUrl = mmodel.iconaddress;
                    [images addObject:imageUrl];
                }
                if (images.count > 0) {
                    self.bannerCycleView.imageURLStringsGroup = images;
                    
                }
            }
        }
    }];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
     FSHomeModel *model = self.homeVM.rac_resObj[0];
    if (model && [model isKindOfClass:[FSHomeModel class]]) {
        FSMovieModel *mmodel = model.data[index];
        [self.homeVM.didSelectCommand execute:mmodel];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
