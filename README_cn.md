# PayBy-inApp-iOS

PayBy Payment Gateway integration SDK for ios with In-app pay scenes
## 术语说明
- deviceId：用于区分不同设备的唯一标识
- partnerId：商户申请支付服务时候被分配的商户id，用以区分不同商户
- appId：商户申请支付服务时候被分配的appId,用以区分商户下不同APP
- token：包含订单信息的token
- Sign：通过对deviceId、partnerId、appId、token拼接而成的签名字符串加密生成。拼接字符串规则如下所示：String signString ="iapAppId="+appId+ "&iapDeviceId=" + deviceId+ "&iapPartnerId=" + partnerId+"&token=" + token ;signString的加密规则可见demo
## 适用版本
使用 Xcode 10 及以上版本可以使用新版 SLDPayByPayment SDK，ios 10.0以上版本
## 集成方式 
### Cocoapods集成

[1] 在 XCode 中建立你的工程。

[2]  在工程的 Podfile 里面添加以下代码：
```
  pod 'PXRPPayByPayment'

```
保存并执行 pod install,然后用后缀为.xcworkspace 的文件打开工程。
注意：如果您现在正在使用`SLDPayByPayment`，请用`PXRPPayByPayment`替换它，运行pod安装进行安装，然后新的`SLDPayByPayment.framework`将被集成到您的项目中。 `SLDPayByPayment` pod不再被维护。

[3] 在 Xcode 中，选择你的工程设置项，选中“TARGETS”一栏，在“info”标签栏的“URL type“添加“URL scheme”为你所注册的应用程序 “payby”+iapAppId（如下图所示）。
![Image text](https://github.com/PayBy/PayBy-inApp-IOS/blob/master/1591697884928.jpg) 

Xcode 设置 URL scheme

[4] 在Xcode中，选择你的工程设置项，选中“TARGETS”一栏，在 “info”标签栏的“LSApplicationQueriesSchemes“添加payby （如下图所示）。
![Image text](https://github.com/PayBy/PayBy-inApp-IOS/blob/master/1591696719298.jpg)

[5] 在你需要使 用PayBy终端 API 的文件中  #import <SLDPayByPayment/SLDPayByPayment.h>.h 头文件。
```
#import <UIKit/UIKit.h>
#import <SLDPayByPayment/SLDPayByPayment.h>

@interface AppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
```
###  在代码中使用开发工具包
#### 初始化SDK（必须）
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Setting up the development environment
  [SDLPayByPaymentInterface paymentEnvironment:SDLPaymentEnvironmentTest]
   [SDLPayByPaymentInterface initInApp:appId partnerId:partnerId];
    return YES;
}

```
  在使用类中调用
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
  APP支付结果监控
 ios 12以下监控代码 
   在项目AppDelegate添加代理监控
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
 ios13 以上  在项目SceneDelegate添加代理监控
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
获取支付结果    result
#### 支付结果码说明
- SUCCESS: 收款方收款成功，该订单的整个支付流程结束
- FAIL：支付失败
- PAID：付款方付款成功。等待收款方收款，同时也可通过接口查询跟踪订单支付状态。
- PAYING：正在处理中。等待支付流程完成，返回最终支付结果。


