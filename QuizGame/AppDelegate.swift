//
//  AppDelegate.swift
//  QuizGame
//
//  Created by Five Admin on 4/2/19.
//  Copyright © 2019 Five Admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
 
        var root:UIViewController;
        
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "username")
        if (value != nil){
            //let myViewController = MyViewController()
            root = TabBarController()
            
        }
        else{
            root = MyLoginScreen()
        }
        
        //let vc = MyLoginScreen()
        navigationController = UINavigationController(rootViewController: root)
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
        
        return true
    }
    

    func switchViewControllers() {
        
        let vc = MyLoginScreen()
        //let vc = TabBarController()
        
        navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        self.window?.rootViewController = navigationController
        
    }
    
    func switchToTabBarController() {
        
        let vc = TabBarController()
        
        navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        self.window?.rootViewController = navigationController
        
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }




}

