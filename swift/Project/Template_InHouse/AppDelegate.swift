//
//  AppDelegate.swift
//  mPaasSwift
//
//  Created by bob on 2020/2/6.
//  Copyright © 2020 Bytedance. All rights reserved.
//

import UIKit
import OneKit
import SwiftOneKit


@UIApplicationMain

@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        
        return super.application(application, willFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        OneKitApp.start()
        OKSwiftLog.debug("AppDelegate", "Test log")
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if (OKStartUpSchemeHandler.shared().handle(url, application: app, scene: nil, options: options)) {
            return true
        }

        return super.application(app, open: url, options: options)
    }

}
