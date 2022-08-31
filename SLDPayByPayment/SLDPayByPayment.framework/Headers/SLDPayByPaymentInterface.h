//
//  SLDPayByPaymentInterface.h
//  SLDPayByPayment
//
//  Created by lengchuanxin on 2022/8/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SLDPayByPaymentColor : NSObject
@property (nonatomic, strong, readonly) UIColor *lightColor;
@property (nonatomic, strong, readonly) UIColor *darkColor;

+ (instancetype)colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;
@end

@interface SLDPayByPaymentConfig : NSObject
/// Payment method menu background color
@property (nonatomic, strong) SLDPayByPaymentColor *paymentMethodMenuColor;
/// Payment method menu text color
@property (nonatomic, strong) SLDPayByPaymentColor *paymentMethodTextColor;
/// Primary color
@property (nonatomic, strong) SLDPayByPaymentColor *primaryColor;
/// Whether to use the default payment result page，Default is YES
@property (nonatomic, assign) BOOL useDefaultResultPage;
/// Whether to use QR code for App payment is only valid for iPhone, and it is always YES for iPad
@property (nonatomic, assign) BOOL appPayUseQrCode;

+ (instancetype)defaultConfig;
@end

typedef NS_ENUM(NSInteger, SLDPayByPaymentLanguage) {
    SLDPayByPaymentLanguageEn, // English
    SLDPayByPaymentLanguageAr, // Arabic
};

typedef NS_ENUM(NSInteger, SLDPayByPaymentEnvironment) {
    SLDPayByPaymentEnvironmentDevelop,
    SLDPayByPaymentEnvironmentUAT,
    SLDPayByPaymentEnvironmentRelease,
};

typedef NS_ENUM(NSInteger, SLDPayByPaymentUserInterfaceStyle) {
    SLDPayByPaymentUserInterfaceStyleUnspecified,
    SLDPayByPaymentUserInterfaceStyleLight,
    SLDPayByPaymentUserInterfaceStyleDark,
};

FOUNDATION_EXPORT NSNotificationName const SLDPayByPaymentResultNotificationName;

typedef void(^SLDPayByPaymentResultCallback)(NSString *result);

@interface SLDPayByPaymentInterface : NSObject

/// To initialize the SDK
/// @param appId Every app of a merchant is assigned an appId while applying for the payment service
/// @param partnerId Every merchant is assigned a partnerId while applying for the payment service
/// @param environment Server Environment
+ (void)initWithAppId:(NSString *)appId partnerId:(NSString *)partnerId environment:(SLDPayByPaymentEnvironment)environment;;

/// Set whether to enable logging
/// @param enabled Default is NO
+ (void)setLogEnabled:(BOOL)enabled;

/// Set language
/// @param language Default is SLDPayByPaymentLanguageEn
+ (void)setLanguage:(SLDPayByPaymentLanguage)language;
 
/// Set user interface style
/// @param userInterfaceStyle Default is SLDPayByPaymentUserInterfaceStyleUnspecified
+ (void)setUserInterfaceStyle:(SLDPayByPaymentUserInterfaceStyle)userInterfaceStyle;

/// Update config
/// @param config Config object
+ (void)updateConfig:(SLDPayByPaymentConfig *)config;

/// Payment
/// @param viewController Show in view controller
/// @param token Order token
/// @param sign For the signature, see the document for the generation rule
/// @param deviceId Every device has its own unique deviceId. UAT environment [joint debugging] fixed: deviceId123
/// @param resultCallback Payment result callback
+ (void)paymentInViewController:(UIViewController *)viewController
                      withToken:(NSString *)token
                           sign:(NSString *)sign
                       deviceId:(NSString *)deviceId
                 resultCallback:(nullable SLDPayByPaymentResultCallback)resultCallback;

/// The SDK version
+ (NSString *)version;

/// Handle open URL
/// @param url Open URL
+ (BOOL)handleOpenURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
