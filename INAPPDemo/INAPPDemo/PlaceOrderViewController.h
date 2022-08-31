//
//  PlaceOrderViewController.h
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceOrderViewController : UIViewController

@property (nonatomic, copy, nullable) void(^confirmHandler)(NSString *amount, NSString *subject, NSString * _Nullable customerId);

@end

NS_ASSUME_NONNULL_END
