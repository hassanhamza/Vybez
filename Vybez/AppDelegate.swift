//
//  AppDelegate.swift
//  Vybez
//
//  Created by Hassan on 7/22/17.
//  Copyright © 2017 Hassan. All rights reserved.
//

import UIKit
import GGLSignIn
import GoogleSignIn
import UberRides
import LyftSDK
import IQKeyboardManagerSwift
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: (String(describing: configureError))")
        
        Configuration.setSandboxEnabled(true)
        Configuration.setFallbackEnabled(false)
        
        IQKeyboardManager.sharedManager().enable = true
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        
//         GIDSignIn.sharedInstance().handle(url,
//                                                       //added exclamation mark
//            sourceApplication: String(describing: options[UIApplicationOpenURLOptionsKey.sourceApplication]!),
//            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        
//        FBSDKApplicationDelegate.sharedInstance().application(
//            app,
//            open: url as URL!,
//            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,
//            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
//        
//        return true
//        
//    }
    
    @nonobjc func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        LyftConfiguration.developer = (token:"rQbt6zpu18pU43AJBVKNAkEksJJKwgWDXOo0OdUswCT9lqhaXOLUZqLQhS1NguBPvXmxhM6Xue17SdvQd8FWVZK44gVp390vQ1/E0fZaNEXurLMComicGDk=", clientId: "3pVH4LEUxJ4e")
        // Complete other setup
        return true
    }
    
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url as URL!,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
}

