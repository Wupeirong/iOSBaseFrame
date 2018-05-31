//
//  UIScrollView+FSRefresh.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/27.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>


@interface UIScrollView (FSRefresh)


///添加下拉刷新控件
- (MJRefreshNormalHeader *)fs_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock;

///添加上拉加载控件
- (MJRefreshAutoNormalFooter *)fs_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock;

@end
