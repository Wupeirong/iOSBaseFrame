//
//  FSNetworkHelper.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/20.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSNetworkHelper.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "FSNetworkCache.h"


static AFHTTPSessionManager *_sessionManager;
static NSMutableArray *_allSessionTask;

@implementation FSNetworkHelper


+ (void)networkStatusWithBlock:(FSNetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(FSNetworkStatusUnknown) : nil;
                    DLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(FSNetworkStatusNotReachable) : nil;
                    DLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(FSNetworkStatusReachableViaWWAN) : nil;
                    DLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(FSNetworkStatusReachableViaWiFi) : nil;
                    DLog(@"WIFI网络");
                    break;
                    
                default:
                    break;
            }
        }];
    
    });
}


+ (void)initialize{
    _sessionManager = [AFHTTPSessionManager manager];
    //设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 10.f;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    
    [self setSecurityPolicy];
    
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}

+ (void)setSecurityPolicy {
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    _sessionManager.securityPolicy = securityPolicy;
    
}


#pragma mark -GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                     view:(UIView *)view
                  success:(FSRequestSuccess)success
                  failure:(FSRequestFailed)failure {
    return [self GET:URL parameters:parameters responseCache:NO view:view success:success failure:failure];
}

#pragma mark -GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(BOOL)responseCache
                     view:(UIView *)view
                  success:(FSRequestSuccess)success
                  failure:(FSRequestFailed)failure {
//    responseCache != nil ? responseCache([FSNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    //根据view是否为空判断是否要显示loading
    BOOL showHud = view == nil? NO : YES;
    id cache = nil;
    if (responseCache) {
        cache = [FSNetworkCache httpCacheForURL:URL parameters:parameters];
        //如果有缓存，则直接返回缓存数据，不需要显示loading
        if (cache != nil || view == nil) {
            showHud = NO;
            success(cache);
        }else {
            showHud = YES;
        }
    }
    if (showHud) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showHud) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        
        [[self allSessionTask] removeObject:task];
        //本地无缓存时才回调，否则会产生两次回调，一次缓存回调，一次请求回调
        if (cache == nil) {
            success ? success(responseObject) : nil;
        }
        //对数据进行一步缓存
        responseCache ? [FSNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showHud) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}

#pragma mark -POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                      view:(UIView *)view
                   success:(FSRequestSuccess)success
                   failure:(FSRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:NO view:view success:success failure:failure];
}

#pragma mark -POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(BOOL)responseCache
                      view:(UIView *)view
                   success:(FSRequestSuccess)success
                   failure:(FSRequestFailed)failure {
//    responseCache != nil ? responseCache([FSNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    //根据view是否为空判断是否要显示loading
    BOOL showHud = view == nil? NO : YES;
    id cache = nil;
    if (responseCache) {
        cache = [FSNetworkCache httpCacheForURL:URL parameters:parameters];
        //如果有缓存，则直接返回缓存数据，不需要显示loading
        if (cache != nil || view == nil) {
            showHud = NO;
            success(cache);
            
        }else {
            showHud = YES;
        }
    }
    if (showHud) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (showHud) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        [[self allSessionTask] removeObject:task];
        if (cache == nil) {
            success ? success(responseObject) : nil;
        }
        
        responseCache ? [FSNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showHud) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    //添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil;
    
    return sessionTask;
}



//存储所有的请求task数组
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    
    return _allSessionTask;
}

//取消某个请求
+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) {
        return;
    }
    //锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

//取消所有请求
+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        
        [[self allSessionTask] removeAllObjects];
    }
}


#pragma mark - RAC GET
+ (RACSignal *)racGET:(NSString *)URL
           parameters:(NSDictionary *)parameters
        responseCache:(BOOL)responseCache
                 view:(UIView *)view
              success:(FSRequestSuccess)success
              failure:(FSRequestFailed)failure {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self GET:URL parameters:parameters responseCache:responseCache view:view success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            return ;
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
            [subscriber sendCompleted];
            return ;
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


#pragma mark - RAC POST
+ (RACSignal *)racPOST:(NSString *)URL
            parameters:(NSDictionary *)parameters
         responseCache:(BOOL)responseCache
                  view:(UIView *)view
               success:(FSRequestSuccess)success
               failure:(FSRequestFailed)failure {
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [self POST:URL parameters:parameters responseCache:responseCache view:view success:^(id responseObject) {
            if (success) {
                success(responseObject);
            }
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
            return ;
            
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
            [subscriber sendCompleted];
            return ;
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}




@end
