//
//  FSTableViewController.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/26.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewController.h"
#import "UITableView+FSExtention.h"
#import "FSTableView.h"

@interface FSTableViewController : FSBaseViewController<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) FSTableView *tableView;

/// `tableView` 的内容缩进，default is UIEdgeInsetsMake(64,0,0,0)，you can override it
@property (nonatomic, readonly, assign) UIEdgeInsets contentInset;

//@property (nonatomic, strong, readonly) FSTableViewModel *viewModel;

- (void)setupViewModel;

- (void)reloadData ;


@end
