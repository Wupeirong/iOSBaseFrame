//
//  FSTableViewController.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/26.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSTableViewController.h"
#import "FSTableViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import "UIScrollView+FSRefresh.h"


@interface FSTableViewController ()

/// contentInset defaul is (64 , 0 , 0 , 0)
@property (nonatomic, readwrite, assign) UIEdgeInsets contentInset;

@property (nonatomic, strong) FSTableViewModel *viewModel;

@end

@implementation FSTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}



- (void)setupSubViews{
    if (CGRectEqualToRect(self.viewModel.frame, CGRectZero)) {
        self.viewModel.frame = self.view.bounds;
    }
    FSTableView *tableView = [[FSTableView alloc] initWithFrame:self.viewModel.frame style:self.viewModel.style];
    tableView.backgroundColor = FSBackgroundColor;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    tableView.contentInset = self.contentInset;
    self.tableView = tableView;
//   这里不做cell的注册，放到子类注册，因为cell可能是xib，也可能不是
//    [self.tableView fs_registerNibCell:self.viewModel.cellCls];

    [self installRefreshHeaderAndFooter];
    
}

- (void)installRefreshHeaderAndFooter {
    //添加下拉刷新控件
    if (self.viewModel.shouldPullDownToRefresh) {
        FSWeakSelf(self)
        self.viewModel.page = 1;
        [self.tableView fs_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
            FSStrongSelf(self)
            [self tableViewDidTriggerHeaderRefresh];
    
        }] ;
        
        [self.tableView.mj_header beginRefreshing];
    }
    
    if (self.viewModel.shouldPullUpToLoadMore) {
            ///上拉加载
        FSWeakSelf(self);
        [self.tableView fs_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
            FSStrongSelf(self);
            [self tableViewDidTriggerFooterRefresh];
        }];
        
        RAC(self.tableView.mj_footer, hidden) = [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] map:^id _Nullable(NSArray *dataSource) {
            FSStrongSelf(self);
            NSUInteger count = dataSource.count;

            if (count == 0) {
                return @1;
            }
            if (self.viewModel.shouldEndRefreshingWithNoMoreData) {
                return @0;
            }

            return (count % self.viewModel.pageSize) ? @1 : @0;
        }];
    }
    if (@available(iOS 11.0, *)) {
        /// iOS 11上发生tableView顶部有留白，原因是代码中只实现了heightForHeaderInSection方法，而没有实现viewForHeaderInSection方法。那样写是不规范的，只实现高度，而没有实现view，但代码这样写在iOS 11之前是没有问题的，iOS 11之后应该是由于开启了估算行高机制引起了bug。
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

#pragma mark -下拉刷新事件
- (void)tableViewDidTriggerHeaderRefresh {
    FSWeakSelf(self);
    
    [self.viewModel requestDataWithPage:1 success:^(id responseObject) {
         [weakself.tableView.mj_header endRefreshing];
        ///重置没有更多的状态
        if (weakself.viewModel.shouldEndRefreshingWithNoMoreData) {
            [weakself.tableView.mj_footer resetNoMoreData];
        }
        [weakself reloadData];
    } failure:^(NSError *error) {
         [weakself.tableView.mj_header endRefreshing];
    }];
}

#pragma mark -上拉加载事件
- (void)tableViewDidTriggerFooterRefresh {
    FSWeakSelf(self)
    [self.viewModel requestDataWithPage:(self.viewModel.page + 1) success:^(id responseObject) {
        [weakself.tableView.mj_footer endRefreshing];
        [weakself requestDataCompleted];
        
    } failure:^(NSError *error) {
        [weakself.tableView.mj_footer endRefreshing];
        [weakself requestDataCompleted];
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)requestDataCompleted {
    NSUInteger count = self.viewModel.dataSource.count;
    /// CoderMikeHe Fixed: 这里必须要等到，底部控件结束刷新后，再来设置无更多数据，否则被叠加无效
    if (self.viewModel.shouldEndRefreshingWithNoMoreData && count%self.viewModel.pageSize) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }
}

#pragma mark - sub class can override it
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/// duqueueReusavleCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

/// configure cell data 可以在这里为cell绑定数据，子类重写
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    if (self.viewModel.shouldMultiSections) return self.viewModel.dataSource ? self.viewModel.dataSource.count : 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.viewModel.shouldMultiSections) return [self.viewModel.dataSource[section] count];
   
    return self.viewModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.viewModel.cellCls) forIndexPath:indexPath];
    
    // fetch object
    id object = nil;
    if (self.viewModel.shouldMultiSections) object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (!self.viewModel.shouldMultiSections) object = self.viewModel.dataSource[indexPath.row];
    
    /// bind model
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // execute commond
    [self.viewModel.didSelectCommand execute:indexPath];
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
