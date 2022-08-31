//
//  UniversalApi.h
//  Hundun
//
//  Created by lengchuanxin on 2022/8/8.
//

#import <Foundation/Foundation.h>
#import <Hundun/HundunError.h>
#import <Hundun/libhundun_universal.h>

NS_ASSUME_NONNULL_BEGIN

@interface UniversalApi : NSObject

/// 设置网络请求头
+ (void)setNetworkHeaderWithKey:(NSString *)key value:(NSString *)value;

/// 通用请求
/// @param path 请求路径
/// @param parameters 请求参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)universalPost:(NSString *)path
           parameters:(nullable NSDictionary *)parameters
              success:(void(^)(NSDictionary *responseDict))success
              failure:(void(^)(HundunError *error))failure;

/// 获取加密盐
/// @param success 成功回调
/// @param failure 失败回调
+ (void)universalGetSaltSuccess:(void(^)(NSString *salt))success
                        failure:(void(^)(HundunError *error))failure;

/// 加密数据（同步）
/// @param originalValue 原值
/// @param salt 加密盐
/// @param success 成功回调
/// @param failure 失败回调
+ (void)universalRsaEncrypt:(NSString *)originalValue
                       salt:(NSString *)salt
                    success:(void(^)(NSString *encryptValue))success
                    failure:(void(^ __nullable)(HundunError *error))failure;

/// 加密数据（同步）
/// @param originalValue 原值
/// @param salt 加密盐
+ (NSString *)universalRsaEncrypt:(NSString *)originalValue salt:(NSString *)salt;

@end

NS_ASSUME_NONNULL_END
