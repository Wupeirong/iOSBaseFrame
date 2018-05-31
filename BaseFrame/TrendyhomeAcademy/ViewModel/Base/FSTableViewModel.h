//
//  FSTableViewModel.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/26.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSBaseViewModel.h"

@interface FSTableViewModel : FSBaseViewModel

/// The data source of table view. 这里不能用NSMutableArray，因为NSMutableArray不支持KVO，不能被RACObserve
@property (nonatomic, strong) NSArray *dataSource;

/// tableView‘s style defalut is UITableViewStylePlain , 只适合 UITableView 有效
@property (nonatomic, assign) UITableViewStyle style;
///tableview的frame
@property (nonatomic, assign) CGRect frame;
///cell的class
@property (nonatomic, assign) Class cellCls;
///是否需要下拉刷新
@property (nonatomic, assign) BOOL shouldPullDownToRefresh;
///是否需要上拉加载更多
@property (nonatomic, assign) BOOL shouldPullUpToLoadMore;
///当前页
@property (nonatomic, assign) NSUInteger page;
///每页数据量
@property (nonatomic, assign) NSUInteger pageSize;

/// 是否数据是多段 (It's effect tableView's dataSource 'numberOfSectionsInTableView:') defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldMultiSections;

/// 是否在上拉加载后的数据,dataSource.count < pageSize 提示没有更多的数据.default is NO 默认做法是数据不够时，隐藏mj_footer
@property (nonatomic, readwrite, assign) BOOL shouldEndRefreshingWithNoMoreData;
///网络请求数据的命令
@property (nonatomic, readonly, strong) RACCommand *requestRemoteDataCommand;

/// 选中命令 eg:  didSelectRowAtIndexPath:
@property (nonatomic, readwrite, strong) RACCommand *didSelectCommand;

//- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page;


- (void)requestDataWithPage:(NSUInteger)page success:(FSRequestSuccess)success failure:(FSRequestFailed)failure;


@end
