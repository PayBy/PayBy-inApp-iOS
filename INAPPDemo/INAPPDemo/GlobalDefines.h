//
//  GlobalDefines.h
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalDefines : NSObject

+ (NSString *)appId;
+ (NSString *)partnerId;
+ (NSString *)privateKey;
+ (NSString *)placeOrderUrl;
+ (NSString *)environment;

@end

NS_ASSUME_NONNULL_END
