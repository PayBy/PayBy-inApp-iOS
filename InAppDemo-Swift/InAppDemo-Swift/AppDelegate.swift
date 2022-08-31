//
//  AppDelegate.swift
//  InAppDemo-Swift
//
//  Created by lengchuanxin on 2022/8/24.
//

import UIKit
import SLDPayByPayment

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SLDPayByPaymentInterface.setLogEnabled(true)
        SettingViewController.initSetting()
        var environment: SLDPayByPaymentEnvironment = .develop
        if GlobalDefines.environment() == "UAT" {
            environment = .UAT
        } else if GlobalDefines.environment() == "REL" {
            environment = .release
        }
        SLDPayByPaymentInterface.initWithAppId(GlobalDefines.appId(), partnerId: GlobalDefines.partnerId(), environment: environment)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CustomNavigationController()
        window?.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return SLDPayByPaymentInterface.handleOpen(url)
    }
    
}

