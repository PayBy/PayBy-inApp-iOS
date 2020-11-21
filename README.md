# PayBy-inApp-iOS

PayBy Payment Gateway integration SDK for ios with In-app pay scenes
## Term Definition
- deviceId：every device has its own unique deviceId. UAT environment [joint debugging] fixed: deviceId123
- partnerId：every merchant is assigned a partnerId while applying for the payment service
- appId：every app of a merchant is assigned an appId while applying for the payment service
- token：it contains order information
- Sign：first, generate a singString by arranging deviceId、partnerId、appId、tokenn order.The rules are as follows：String signString ="iapAppId="+appId+ "&iapDeviceId=" + deviceId+ "&iapPartnerId=" + partnerId+"&token=" + token ;Second,sign the signString with privateKey， and the encryption rules can be seen in the demo.
## Applicable version
Use Xcode 10 and above to use the new version of SLDPayByPayment SDK, ios 10.0 and above
## Installation
### Installation with CocoaPods

[1] Build your project in XCode.

[2]  To integrate SLDPayByPayment into your Xcode project using CocoaPods, specify it in your Podfile：
```
  pod 'PXRPPayByPayment'
```
Save and execute pod install, then open the project with a file with the suffix .xcworkspace.
Note: If you are using `SLDPayByPayment` now, Please replace it with `PXRPPayByPayment`,  run `pod install` to install, and then the new `SLDPayByPayment.framework` will be integrated into you project. `SLDPayByPayment` pod doesn't been maintained any more.

[3] In Xcode, select your project settings, select the "TARGETS" column, and add "URL scheme" to the "URL type" in the "info" tab bar for your registered application "payby" + iapAppId (As shown).
![Image text](https://github.com/PayBy/PayBy-inApp-IOS/blob/master/1591697884928.jpg) 

[4] In Xcode, select your project settings, select the "TARGETS" column, and add payby to "LSApplicationQueriesSchemes" in the "info" tab (As shown).
![Image text](https://github.com/PayBy/PayBy-inApp-IOS/blob/master/1591696719298.jpg)

[5] In the file you need to use the PayBy terminal API #import <SLDPayByPayment/SLDPayByPayment.h>.h header file.
```
#import <UIKit/UIKit.h>
#import <SLDPayByPayment/SLDPayByPayment.h>

@interface AppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
```
###  Usage
#### Initialize SDK (required)
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //Setting up the development environment
   [SDLPayByPaymentInterface paymentEnvironment:SDLPaymentEnvironmentTest];
   [SDLPayByPaymentInterface initInApp:appId partnerId:partnerId];
    return YES;
}

```
  SDLPaymentEnvironment Description：<br>
    - SDLPaymentEnvironmentDev:the environment for developing and testing.<br>
    - SDLPaymentEnvironmentTest:the environment for customer debuging.<br>
    - SDLPaymentEnvironmentRelease:the environment for product online.<br>
  
  Call methods in your class
```
    [SDLPayByPaymentInterface payInAppWithViewContorller:self orderCallback:^(OrderSuccessCallback  _Nonnull orderSuccessCallback, OrderFailCallback  _Nonnull orderFailCallback) {
        //get order token
        NSString *token = [self getTokenMock];
        if (token && token.length > 0) {
            orderSuccessCallback(token,deviceId,sigin);
        }else{
            orderFailCallback();
        }
    } success:^(id  _Nonnull result) {
        if([result isKindOfClass:[NSString class]]){
            [self alertView:result];
        }
    } fail:^(NSError * _Nonnull error) {
        [self alertView:error.userInfo[@"errorInfo"]];
    }];
```
Get The Payment Result
 AppDelegate adds proxy monitoring[below ios12]
 ```
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url.absoluteString];
    for(NSURLQueryItem *info in components.queryItems){
        if([info.name isEqualToString:@"result"]){
            NSLog(@"result = %@",info.value);
                              break;
        }
    }
    return YES;
    
}

 ```
 Add proxy monitoring to the project SceneDelegate[iOS13 or above]
 ```
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts API_AVAILABLE(ios(13.0)){
    
    for (UIOpenURLContext *obj in URLContexts) {
        NSURL *tempUrl = obj.URL;
        if([tempUrl.absoluteString hasPrefix:@"payby"]){
           NSURLComponents *components = [[NSURLComponents alloc] initWithString:tempUrl.absoluteString];
           for(NSURLQueryItem *info in components.queryItems){
               if([info.name isEqualToString:@"result"]){
                   NSLog(@"result = %@",info.value);
                              break;
               }
           }
            break;;
        }
    }
}
 ```
#### Payment Result Code Description
- SUCCESS: the payee has received the payment successfully, and the entire payment process for the order is completed.
- FAIL: payment failed.
- PAID: the payer paid successfully. Wait for the payee to receive the payment, at the same time, you can also query and track the payment status of the order by order NO.
- PAYING: processing. Wait for the payment process to complete and return the final payment result.


