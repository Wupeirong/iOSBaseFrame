//
//  FSLiveViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/27.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSLiveViewController.h"
#import "FSLiveViewModel.h"
#import "MHMainFrameTableViewCell.h"


@interface FSLiveViewController ()

@property (nonatomic, strong) FSLiveViewModel *viewModel;

@end

@implementation FSLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播";
    // Do any additional setup after loading the view.
    
    [self.tableView fs_registerNibCell:NSClassFromString(@"MHMainFrameTableViewCell")];
}

- (void)setupViewModel {
    FSLiveViewModel *viewModel = [[FSLiveViewModel alloc] init];
    viewModel.parentView = self.view;
    viewModel.cellCls = NSClassFromString(@"MHMainFrameTableViewCell");
    self.viewModel = viewModel;
    
}

- (UIEdgeInsets)contentInset{
    CGFloat topH = FSTopHeight;
    CGFloat tabH = FSTabBarHeight;
    return UIEdgeInsetsMake(0, 0, topH + tabH, 0);
}


/// 返回自定义的cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    // ②：父类的tableView的数据源方法的获取cell是通过注册cell的identifier来获取cell，然而此时子类并未注册cell，所以取出来的cell = nil而引发Crash
    return [tableView dequeueReusableCellWithIdentifier:@"MHMainFrameTableViewCell"];
    // 非注册cell 使用时：去掉ViewDidLoad里面注册Cell的代码
    //    return [MHMainFrameTableViewCell cellWithTableView:tableView];
}


/// 绑定数据
- (void)configureCell:(MHMainFrameTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell bindViewModel:object];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 + FSScreenWidth + 7;
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
