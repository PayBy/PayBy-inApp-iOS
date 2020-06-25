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
NS_ASSUME_NONNULL_BEGIN

@interface SDLPayByPaymentInterface : NSObject
+ (void)initInApp:(NSString *)appid partnerId:(NSString *)partnerId;

///Default SDLPaymentEnvironmentDEV
/// @param environment Default SDLPaymentEnvironmentDEV
+ (void)paymentEnvironment:(SDLPaymentEnvironment)environment;

/// IapApp Init
/// @param token every device has its own unique deviceId
/// @param sign sign the signString with privateKey
///  @param vc show VC
///  @param deviceId every device has its own unique deviceId
/// @param success <#success description#>
/// @param fail <#fail description#>
+ (void)requestInApp:(NSString *)token DeviceId:(NSString *)deviceId Sign:(NSString *)sign PageOnViewContorller:(UIViewController *)vc  success:(void(^)(id result))success fail:(void(^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_END
