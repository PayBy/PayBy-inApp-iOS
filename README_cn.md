# PayBy-inApp-iOS

PayBy为iOS应用内支付场景提供的支付网关集成SDK
## 术语说明
- deviceId: 用于区分不同设备的唯一标识. UAT环境固定: deviceId123
- partnerId: 商户申请支付服务时候被分配的商户id，用以区分不同商户
- appId: 商户申请支付服务时候被分配的appId，用以区分商户下不同APP
- token: 包含订单信息的token，商户下单时收到的响应
- sign: 通过对deviceId、partnerId、appId、token拼接而成的签名字符串加密生成。拼接字符串规则如下所示：String signString = "iapAppId="+appId+"&iapDeviceId="+deviceId+"&iapPartnerId="+partnerId+"&token="+token；signString的加密规则可见demo

## 适用版本
使用Xcode 10及以上版本可以使用新版SLDPayByPayment SDK，iOS 10.0以上版本

## 集成方式 
### Cocoapods集成

[1] 在 XCode 中建立你的工程。

[2] 在工程的 Podfile 里面添加以下代码：
```
# 必须添加此源
source 'https://github.com/PayBy/CocoaPodsSpecs.git' 

pod 'PXRPPayByPayment'
```
保存并执行 `pod install`，然后用后缀为.xcworkspace 的文件打开工程。
注意：如果您现在正在使用`SLDPayByPayment`，请用`PXRPPayByPayment`替换它，运行pod安装进行安装，然后新的`SLDPayByPayment.framework`将被集成到您的项目中。 `SLDPayByPayment` pod不再被维护。

[3] 在 Xcode 中，选择你的工程设置项，选中"TARGETS"一栏，在"Info"标签栏的"URL Types"添加"URL scheme"为你所注册的应用程序 "payby" + iapAppId（如下图所示）。
![Image text](https://github.com/PayBy/PayBy-inApp-iOS/blob/master/1661319255013.jpg) 

[4] 在 Xcode 中，选择你的工程设置项，选中"TARGETS"一栏，在"Build Settings"标签栏中将"Architectures"改为"arm64"（如下图所示）。
![Image text](https://github.com/PayBy/PayBy-inApp-iOS/blob/master/1661244568047.jpg)

[5] 在 Xcode 中，选择你的工程设置项，选中"TARGETS"一栏，在"Build Settings"标签栏中将"Enable Bitcode"改为"No"（如下图所示）。
![Image text](https://github.com/PayBy/PayBy-inApp-iOS/blob/master/1661244707155.jpg)

### 使用
#### 初始化SDK（必须）
```
#import "AppDelegate.h"
#import <SLDPayByPayment/SLDPayByPayment.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [SLDPayByPaymentInterface setLogEnabled:YES];
    
//    [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageEn];
//    [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleDark];
//    SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
//    config.paymentMethodMenuColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor redColor] darkColor:[UIColor greenColor]];
//    config.paymentMethodTextColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]];
//    config.primaryColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor blueColor] darkColor:[UIColor blueColor]];
//    config.appPayUseQrCode = NO;
//    config.useDefaultResultPage = YES;
//    [SLDPayByPaymentInterface updateConfig:config];

    [SLDPayByPaymentInterface initWithAppId:{appId} partnerId:{partnerId} environment:SLDPayByPaymentEnvironmentDevelop];

    ...

    return YES;
}

@end
```

SLDPayByPaymentEnvironment 说明:<br>
- SLDPayByPaymentEnvironmentDevelop: 测试环境<br>
- SLDPayByPaymentEnvironmentUAT: UAT环境<br>
- SLDPayByPaymentEnvironmentRelease: 生产环境<br>

在使用类中调用 (Objective-C)
```
NSString *sign = [NSString stringWithFormat:@"iapAppId=%@&iapDeviceId=%@&iapPartnerId=%@&token=%@", self.appIdTextField.text, self.deviceIdTextField.text, self.partnerIdTextField.text, self.tokenTextField.text];
[SLDPayByPaymentInterface paymentInViewController:self withToken:self.tokenTextField.text sign:[GPBRSA encryptString:sign privateKey:[GlobalDefines privateKey]] deviceId:self.deviceIdTextField.text resultCallback:^(NSString * _Nonnull result) {
    NSLog(@"resultCallback: %@", result);
    if ([SLDPayByPaymentConfig defaultConfig].useDefaultResultPage == NO) {
        [self showAlertWithMessage:result];
    }
}];
```

在使用类中调用 (Swift)
```
let token = self.tokenTextField.text ?? ""
let deviceId = self.deviceIdTextField.text ?? ""
let sign = "iapAppId=\(self.appIdTextField.text ?? "")&iapDeviceId=\(deviceId)&iapPartnerId=\(self.partnerIdTextField.text ?? "")&token=\(token)"
SLDPayByPaymentInterface.payment(in: self, withToken: token, sign: GPBRSA.encryptString(sign, privateKey: GlobalDefines.privateKey()), deviceId: deviceId) { [weak self] result in
    print("resultCallback: \(result)")
    if SLDPayByPaymentConfig.default().useDefaultResultPage == false {
        self?.showAlert(with: result)
    }
}
```

#### 支付结果码说明
- SUCCESS: 收款方收款成功，该订单的整个支付流程结束
- FAIL: 支付失败
- PAYING: 正在处理中。等待支付流程完成，返回最终支付结果。
- CANCEL: 取消支付，用户点击关闭按钮后收到的回调状态

## 1.x.x版本迁移2.x.x版本指南

[1] 在工程的 Podfile 里面添加以下代码：
```
# 必须添加此源
source 'https://github.com/PayBy/CocoaPodsSpecs.git' 

pod 'PXRPPayByPayment'
```
[2] 请使用SLDPayByPaymentInterface替代SDLPayByPaymentInterface

[3] 初始化SDK，请使用以下代码
```
#import "AppDelegate.h"
#import <SLDPayByPayment/SLDPayByPayment.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [SLDPayByPaymentInterface setLogEnabled:YES];
    
//    [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageEn];
//    [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleDark];
//    SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
//    config.paymentMethodMenuColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor redColor] darkColor:[UIColor greenColor]];
//    config.paymentMethodTextColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]];
//    config.primaryColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor blueColor] darkColor:[UIColor blueColor]];
//    config.appPayUseQrCode = NO;
//    config.useDefaultResultPage = YES;
//    [SLDPayByPaymentInterface updateConfig:config];

    [SLDPayByPaymentInterface initWithAppId:{appId} partnerId:{partnerId} environment:SLDPayByPaymentEnvironmentDevelop];

    ...

    return YES;
}

@end
```
替换代码
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Setting up the development environment
    [SDLPayByPaymentInterface paymentEnvironment:SDLPaymentEnvironmentTest]
    [SDLPayByPaymentInterface initInApp:appId partnerId:partnerId];
    return YES;
}
```
[4] 在使用类中调用，请使用以下代码
```
NSString *sign = [NSString stringWithFormat:@"iapAppId=%@&iapDeviceId=%@&iapPartnerId=%@&token=%@", self.appIdTextField.text, self.deviceIdTextField.text, self.partnerIdTextField.text, self.tokenTextField.text];
[SLDPayByPaymentInterface paymentInViewController:self withToken:self.tokenTextField.text sign:[GPBRSA encryptString:sign privateKey:[GlobalDefines privateKey]] deviceId:self.deviceIdTextField.text resultCallback:^(NSString * _Nonnull result) {
    NSLog(@"resultCallback: %@", result);
    if ([SLDPayByPaymentConfig defaultConfig].useDefaultResultPage == NO) {
        [self showAlertWithMessage:result];
    }
}];
```
替换代码
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


