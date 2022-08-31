//
//  HttpManager.h
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HttpSuccessHandler)(id _Nullable responseObject);
typedef void(^HttpFailureHandler)(NSError *error);
typedef void(^HttpProgressHandler)(NSProgress *downloadProgress);

@interface HttpManager : NSObject

+ (instancetype)sharedManager;

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable HttpSuccessHandler)success
                               failure:(nullable HttpFailureHandler)failure;

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable HttpProgressHandler)downloadProgress
                               success:(nullable HttpSuccessHandler)success
                               failure:(nullable HttpFailureHandler)failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable HttpSuccessHandler)success
                                failure:(nullable HttpFailureHandler)failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable HttpProgressHandler)uploadProgress
                                success:(nullable HttpSuccessHandler)success
                                failure:(nullable HttpFailureHandler)failure;

@end

NS_ASSUME_NONNULL_END
