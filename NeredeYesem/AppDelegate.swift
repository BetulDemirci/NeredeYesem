//
//  AppDelegate.swift
//  NeredeYesem
//
//  Created by Semafor on 23.08.2020.
//  Copyright © 2020 Semafor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let locationService = LocationService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let userLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if (userLoggedIn){
            //check location status!!
            switch locationService.status {
            case .notDetermined, .denied, .restricted:
                let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
                window.rootViewController = locationViewController
            default:
                 let nav = storyboard
                               .instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
               window.rootViewController = nav
               locationService.getLocation()
               (nav?.topViewController as? HomeViewController)?.delegete = self as? ListActions
            }
        }else{
           let viewController = storyboard.instantiateViewController(withIdentifier: "page") as!
           PageViewController
           window.rootViewController = viewController
           
        }
         window.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    


}

