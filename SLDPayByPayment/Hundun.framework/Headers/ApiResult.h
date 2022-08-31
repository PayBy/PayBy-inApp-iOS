//
// Created by Zenas Song on 2021/7/3.
//

#import <Foundation/Foundation.h>
#import <Hundun/HundunResult.h>
#import <Hundun/HundunError.h>

@interface ApiResult<T> : NSObject
/// create an api result;
+ (instancetype)create:(HundunResult<HundunError *, T> *)result;

/// execute effect on success;
- (void)onSuccess:(void (^)(T obj))block;

/// execute effect on failure;
- (void)onError:(void (^)(HundunError *obj))block;
@end

@interface ApiResultMapper<Input, Output> : NSObject
- (ApiResult<Output> *)map:(ApiResult<Input> *)result withBlock:(Output (^)(Input obj))block;
@end

@interface ApiResultFlatMapper<Input, Output> : NSObject
- (ApiResult<Output> *)flatMap:(ApiResult<Input> *)result
                     withBlock:(HundunResult<HundunError *, Output> *(^)(Input obj))block;
@end