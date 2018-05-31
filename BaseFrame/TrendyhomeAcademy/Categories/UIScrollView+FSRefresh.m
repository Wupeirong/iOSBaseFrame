//
//  UIScrollView+FSRefresh.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/27.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "UIScrollView+FSRefresh.h"

@implementation UIScrollView (FSRefresh)

///添加下拉刷新控件
- (MJRefreshNormalHeader *)fs_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock? : refreshingBlock((MJRefreshNormalHeader *)strongSelf.mj_header);
    }];
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = mj_header;
    return mj_header;
}

///添加上拉加载控件
- (MJRefreshAutoNormalFooter *)fs_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock? : refreshingBlock((MJRefreshAutoNormalFooter *)strongSelf.mj_footer);
    }];
    [mj_footer setTitle:@"别拉了，已经到底了..." forState:MJRefreshStateNoMoreData];
    self.mj_footer = mj_footer;
    return mj_footer;
}


@end
