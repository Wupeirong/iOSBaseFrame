//
//  FSHomeViewModel.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/23.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSHomeViewModel.h"
//#import <ReactiveObjC/ReactiveObjC.h>
#import "FSHomeModel.h"


@implementation FSHomeViewModel

- (void)requestHomeData:(FSRequestSuccess)success failure:(FSRequestFailed)failure {
//    [[self racRequestHomeDataWithView:view] subscribeNext:^(id  _Nullable responseObject) {
//        if (responseObject) {
//            NSString *error_code = [responseObject objectForKey:@"error_code"];
//            if (error_code.integerValue == 0) {
//                NSDictionary *result = [responseObject objectForKey:@"result"];
//                NSArray *data = [result objectForKey:@"data"];
//                NSArray *datalist = [FSHomeModel mj_objectArrayWithKeyValuesArray:data];
//                self.rac_resObj = datalist;
//            }
//        }
//    }];
    FSWeakSelf(self)
    NSString *url = [HOME_DATA_LIST_API stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [FSNetworkHelper GET:url parameters:nil responseCache:NO view:self.parentView success:^(id responseObject) {
        if (responseObject) {
            NSString *error_code = [responseObject objectForKey:@"error_code"];
            if (error_code.integerValue == 0) {
                NSDictionary *result = [responseObject objectForKey:@"result"];
                NSArray *data = [result objectForKey:@"data"];
                NSArray *datalist = [FSHomeModel mj_objectArrayWithKeyValuesArray:data];
                self.rac_resObj = datalist;
                if (success) {
                    success(weakself.rac_resObj);
                }
            }else{
                if (success) {
                    success(responseObject);
                }
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//- (RACSignal *)racRequestHomeData {
//
//    NSString *url = [HOME_DATA_LIST_API stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    return [FSNetworkHelper racGET:url parameters:nil responseCache:YES view:self.parentView success:nil failure:nil];
//}

@end
