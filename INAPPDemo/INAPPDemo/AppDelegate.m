//
//  AppDelegate.m
//  INAPPDemo
//
//  Created by ice on 2020/6/23.
//  Copyright © 2020 ice. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GPBRSA.h"
#import <SLDPayByPayment/SLDPayByPayment.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
      [SDLPayByPaymentInterface initInApp:@"20200510000000121" partnerId:@"200000046800"];
    if (@available(ios 13, *)) {
           } else {
               self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
               self.window.backgroundColor = [UIColor whiteColor];
               self.window.rootViewController = [[ViewController alloc]init];
           }
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url.absoluteString];
    for(NSURLQueryItem *info in components.queryItems){
        if([info.name isEqualToString:@"result"]){
            //NSLog(@"result = %@",info.value);
            break;
        }
    }
    return YES;
    
}
@end
