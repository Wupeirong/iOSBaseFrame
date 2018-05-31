//
//  FSLiveViewModel.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/27.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSLiveViewModel.h"
#import "FSLiveModel.h"

@implementation FSLiveViewModel

- (void)initialize {
    [super initialize];
    self.shouldPullDownToRefresh = YES;
    self.shouldPullUpToLoadMore = YES;
    /// NO:没有数据时，隐藏底部刷新控件
    self.shouldEndRefreshingWithNoMoreData = YES;
}

- (void)requestDataWithPage:(NSUInteger)page success:(FSRequestSuccess)success failure:(FSRequestFailed)failure {
    
    [self requestRemoteDataSignalWithPage:page success:success failure:failure];
}


- (void)requestRemoteDataSignalWithPage:(NSUInteger)page success:(FSRequestSuccess)success failure:(FSRequestFailed)failure {
    FSWeakSelf(self)
    NSString *url = GET_ROOM_LIST_API;//[GET_ROOM_LIST_API stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"useridx":@"61856069",
                                 @"type":@1,
                                 @"page":@(page),
                                 @"lat":@(22.54192103514200),
                                 @"lon":@(113.96939828211362),
                                 @"province":@"广东省"
                                 };
     [FSNetworkHelper GET:url parameters:parameters responseCache:NO view:self.parentView success:^(id responseObject) {
        NSString *code = [responseObject objectForKey:@"code"];
        if (code.integerValue == 100) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            NSArray *list = [data objectForKey:@"list"];
            NSArray *liveRooms = [FSLiveModel mj_objectArrayWithKeyValuesArray:list];
            weakself.dataSource = [[weakself dataSourceWithLiveRooms:liveRooms page:weakself.page] copy];
            success(weakself.dataSource);
        }else {
            success(responseObject);
        }
         
    } failure:^(NSError *error) {
        failure(error);
    }];
//    return [FSNetworkHelper racGET:url parameters:parameters responseCache:NO view:self.parentView success:success failure:failure];
}

- (NSArray *)dataSourceWithLiveRooms:(NSArray *)liveRooms page:(NSUInteger)page {
    if (page == 1) {
        //下拉刷新
        return liveRooms;
    }else {
        //上拉加载
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.dataSource];
        [array addObjectsFromArray:liveRooms];
        return array;
    }
}


@end
