//
//  FSNetworkHelper.h
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/20.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSNetworkHelper : NSObject

typedef NS_ENUM(NSUInteger, FSNetworkStatusType) {
    //未知网络
    FSNetworkStatusUnknown,
    //无网络
    FSNetworkStatusNotReachable,
    //手机网络
    FSNetworkStatusReachableViaWWAN,
    //wifi网络
    FSNetworkStatusReachableViaWiFi
};


typedef NS_ENUM(NSUInteger, FSRequestSerializer) {
    /** 设置请求数据为JSON格式*/
    FSRequestSerializerJSON,
    /** 设置请求数据为二进制格式*/
    FSRequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, FSResponseSerializer) {
    /** 设置响应数据为JSON格式*/
    FSResponseSerializerJSON,
    /** 设置响应数据为二进制格式*/
    FSResponseSerializerHTTP,
};

//网络状态的Block
typedef void (^FSNetworkStatus)(FSNetworkStatusType status);

+ (void)networkStatusWithBlock:(FSNetworkStatus)networkStatus;

//网络请求成功的Block
typedef void (^FSRequestSuccess)(id responseObject);
//网络请求失败的Block
typedef void (^FSRequestFailed)(NSError *error);
//网络缓存的Block
//typedef void(^FSRequestCache)(id responseObject);


/**
 *  GET请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                     view:(UIView *)view
                  success:(FSRequestSuccess)success
                  failure:(FSRequestFailed)failure;


/**
 *  GET请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param view          需要显示loading的view
 *  @param responseCache 读取缓存数据
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(BOOL)responseCache
                     view:(UIView *)view
                  success:(FSRequestSuccess)success
                  failure:(FSRequestFailed)failure;


/**
 *  POST请求,无缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param view          需要显示loading的view
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                      view:(UIView *)view
                   success:(FSRequestSuccess)success
                   failure:(FSRequestFailed)failure;

/**
 *  POST请求,自动缓存
 *
 *  @param URL           请求地址
 *  @param parameters    请求参数
 *  @param responseCache 是否读取缓存数据
 *  @param view          需要显示loading的view
 *  @param success       请求成功的回调
 *  @param failure       请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(BOOL)responseCache
                      view:(UIView *)view
                   success:(FSRequestSuccess)success
                   failure:(FSRequestFailed)failure;

/**
 取消所有请求
 */
+ (void)cancelAllRequest;

/**
 取消指定URL的请求
 */
+ (void)cancelRequestWithURL:(NSString *)URL;

#pragma mark - RAC GET
+ (RACSignal *)racGET:(NSString *)URL
           parameters:(NSDictionary *)parameters
        responseCache:(BOOL)responseCache
                 view:(UIView *)view
              success:(FSRequestSuccess)success
              failure:(FSRequestFailed)failure ;

#pragma mark - RAC POST
+ (RACSignal *)racPOST:(NSString *)URL
            parameters:(NSDictionary *)parameters
         responseCache:(BOOL)responseCache
                  view:(UIView *)view
               success:(FSRequestSuccess)success
               failure:(FSRequestFailed)failure;

@end
