//
//  AppDelegate.swift
//  INAPPDemo_swift
//
//  Created by ice on 2020/6/25.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import SLDPayByPayment
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SLDPayByPayment.SDLPayByPaymentInterface.paymentEnvironment(.test)
        SLDPayByPayment.SDLPayByPaymentInterface.initInApp("20200510000000121", partnerId: "200000046800")
        if #available(iOS 13, *) {
                   
               }else {
                   showWindow()
               }
        
        // Override point for customization after application launch.
        return true
    }
    func showWindow() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
       }


    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        let tempQueryItems : Array = (components?.queryItems)!
        
        for info in tempQueryItems {
            if(info.name == "result") {
                print("result\(String(describing: info.value))")
                break;
            }
        }
        
      
        return true
    }

}

