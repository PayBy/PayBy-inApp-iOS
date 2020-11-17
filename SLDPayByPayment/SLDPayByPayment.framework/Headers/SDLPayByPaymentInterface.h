//
//  SDLPayByPaymentInterface.h
//  SLDPayByPayment
//
//  Created by ice on 2020/5/29.
//  Copyright © 2020 ice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,SDLPaymentEnvironment) {
    SDLPaymentEnvironmentDev,
    SDLPaymentEnvironmentTest,
    SDLPaymentEnvironmentRelease
};

typedef void (^OrderSuccessCallback)(NSString * _Nonnull token,NSString * _Nonnull deviceId,NSString * _Nonnull sign);
typedef void (^OrderFailCallback)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SDLPayByPaymentInterface : NSObject
+ (void)initInApp:(NSString *)appid partnerId:(NSString *)partnerId;

///Default SDLPaymentEnvironmentDEV
/// @param environment Default SDLPaymentEnvironmentDEV
+ (void)paymentEnvironment:(SDLPaymentEnvironment)environment;

/**
 *IapApp request pay
 *@param token every device has its own unique deviceId
 *@param sign sign the signString with privateKey
 *@param deviceId every device has its own unique deviceId
 *@param vc show VC
 *@param success pay success result
 *@param fail pay fail
 */
+ (void)requestInApp:(NSString *)token DeviceId:(NSString *)deviceId Sign:(NSString *)sign PageOnViewContorller:(UIViewController *)vc  success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;

/**
 *place an order  to pay
 *@param vc show VC
 *@param orderCallback  sign the signString with privateKey
 *@param success pay success result
 *@param fail pay fail
 */
+ (void)payInAppWithViewContorller:(UIViewController *)vc orderCallback:(void(^)(OrderSuccessCallback orderSuccessCallback,OrderFailCallback orderFailCallback)) orderCallback success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
