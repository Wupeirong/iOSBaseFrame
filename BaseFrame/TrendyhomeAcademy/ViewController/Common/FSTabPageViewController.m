//
//  FSTabPageViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSTabPageViewController.h"

@interface FSTabPageViewController ()

@end

@implementation FSTabPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.itemTitleColor = [UIColor blackColor];
    self.tabBar.itemTitleFont = FSSystemFont(14);
    [self setContentScrollEnabled:YES tapSwitchAnimated:YES];
    
    self.tabBar.indicatorColor = FSColorWithRGB(36, 176, 252);
    
    [self.tabBar setIndicatorInsets:UIEdgeInsetsMake(42, 10, 0, 10) tapSwitchAnimated:YES];
    
}

- (void)viewDidLayoutSubviews {
    [self setTabBarFrame:CGRectMake(0, 0, FSScreenWidth, 44) contentViewFrame:CGRectMake(0, 44, FSScreenWidth, self.view.frame.size.height - 44)];
    
}


- (RACSignal *)contentScrollSignal {
    @weakify(self)
    RACSignal *changedTab = [self rac_signalForSelector:@selector(didSelectViewControllerAtIndex:)];
    return [[[[changedTab map:^__kindof RACSignal *_Nullable(RACTuple *value) {
        @strongify(self);
        id<PageScrollDelegate> scrollVC = (id<PageScrollDelegate>)self.viewControllers[[value.first integerValue]];
        BOOL scrollable = [scrollVC respondsToSelector:@selector(scrollView)];
        return scrollable ? RACObserve(scrollVC.scrollView, contentOffset) : [RACSignal return:[NSNull null]];
    }]switchToLatest] filter:^BOOL(id  _Nullable value) {
        return [value isKindOfClass:NSNull.class] || [value CGPointValue].y != 0;
    }] map:^id _Nullable(id  _Nullable value) {
        if ([value isKindOfClass:NSNull.class]) {
            return value;
        }
        
        @strongify(self);
        id<PageScrollDelegate> scrollVC = (id<PageScrollDelegate>)self.selectedController;
        return scrollVC.scrollView;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
