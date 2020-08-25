//
//  AppDelegate.swift
//  Reciplease
//
//  Created by Giovanni Gaffé on 2020/8/24.
//  Copyright © 2020 Jonathan Gaffé. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "Reciplease")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        guard let navViewController = window?.rootViewController as? UINavigationController, let homeViewController = navViewController.topViewController as? HomeViewController else {
        //            fatalError("Application storyboard is not setup correctly")
        //        }
        //        homeViewController.coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
}

