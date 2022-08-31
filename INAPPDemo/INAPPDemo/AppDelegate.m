//
//  AppDelegate.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/1.
//

#import "AppDelegate.h"
#import "SettingViewController.h"
#import "CustomNavigationController.h"
#import "GlobalDefines.h"
#import <SLDPayByPayment/SLDPayByPayment.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [SLDPayByPaymentInterface setLogEnabled:YES];
    
//    [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageEn];
//    [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleDark];
//    SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig new];
//    config.paymentMethodMenuColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor redColor] darkColor:[UIColor greenColor]];
//    config.paymentMethodTextColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]];
//    config.primaryColor = [SLDPayByPaymentColor colorWithLightColor:[UIColor blueColor] darkColor:[UIColor blueColor]];
//    config.appPayUseQrCode = NO;
//    config.useDefaultResultPage = YES;
//    [SLDPayByPaymentInterface updateConfig:config];
    
    [SettingViewController initSetting];
    
    SLDPayByPaymentEnvironment environment = SLDPayByPaymentEnvironmentDevelop;
    if ([[GlobalDefines environment] isEqualToString:@"UAT"]) {
        environment = SLDPayByPaymentEnvironmentUAT;
    } else if ([[GlobalDefines environment] isEqualToString:@"REL"]) {
        environment = SLDPayByPaymentEnvironmentRelease;
    }
    [SLDPayByPaymentInterface initWithAppId:[GlobalDefines appId] partnerId:[GlobalDefines partnerId] environment:environment];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[CustomNavigationController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [SLDPayByPaymentInterface handleOpenURL:url];
}

@end
