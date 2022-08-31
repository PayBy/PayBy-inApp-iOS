//
//  ColorSettingViewController.h
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorSettingViewController : UIViewController

@property (nonatomic, copy) NSDictionary *colorDict;

@property (nonatomic, copy, nullable) void(^saveColorSettingHandler)(NSString *lightHexStr, NSString *darkHexStr);

@end

NS_ASSUME_NONNULL_END
