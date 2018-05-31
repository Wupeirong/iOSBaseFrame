//
//  FSBaseViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/21.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewController.h"

@interface FSBaseViewController ()

@property (nonatomic, strong) FSBaseViewModel *viewModel;

@end

@implementation FSBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _StatusBarStyle=StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    FSBaseViewController *viewController = [super allocWithZone:zone];
    FSWeakSelf(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        FSStrongSelf(viewController);
        [viewController bindViewModel];
    }];
    
    return viewController;
}


- (instancetype)initWithViewModel:(FSBaseViewModel *)viewModel {

    if (self = [super init]) {
        self.viewModel = viewModel;
        self.viewModel.parentView = self.view;
    }
    
    return self;
}

#pragma mark -初始化viewModel
- (void)setupViewModel {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if (@available(iOS 11.0, *)) {
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = FSBackgroundColor;
    
    [self setupViewModel];
    
}


- (void)bindViewModel {
    
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        //这里可以统一处理某个错误
        DLog(@"...错误❌：%@", error);
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
