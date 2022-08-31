//
//  HttpManager.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/15.
//

#import "HttpManager.h"
#import <AFNetworking/AFNetworking.h>

@interface HttpManager ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation HttpManager

+ (instancetype)sharedManager {
    static HttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HttpManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil]];
        _sessionManager.requestSerializer.timeoutInterval = 8.f;
    }
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    [_sessionManager.requestSerializer setTimeoutInterval:timeoutInterval];
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    return [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters progress:(HttpProgressHandler)downloadProgress success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    NSLog(@"GET START %@ PARAMS IS：%@", URLString, parameters);
    return [_sessionManager GET:URLString parameters:parameters headers:nil progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GET SUCCESS %@ RESPONSE = %@", URLString, responseObject);
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"GET FAILURE %@ \n PARAMS = %@ \n ERROR = %@ \n ERROR REASON = %@", URLString, parameters, error, error.localizedFailureReason);
        if (failure) failure(error);
    }];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    return [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters progress:(HttpProgressHandler)uploadProgress success:(HttpSuccessHandler)success failure:(HttpFailureHandler)failure {
    NSLog(@"POST START %@ PARAMS IS：%@", URLString, parameters);
    return [_sessionManager POST:URLString parameters:parameters headers:nil progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"POST SUCCESS %@ RESPONSE = %@", URLString, responseObject);
        if (success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"POST FAILURE %@ \n PARAMS = %@ \n ERROR = %@ \n ERROR REASON = %@", URLString, parameters, error, error.localizedFailureReason);
        if (failure) failure(error);
    }];
}

@end
