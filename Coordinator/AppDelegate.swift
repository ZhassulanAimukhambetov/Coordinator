//
//  AppDelegate.swift
//  Coordinator
//
//  Created by iOS Developer (KolesaGroup) on 11.09.2023.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //let vc = ViewController()
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        ApplicationCoordinator.shared.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

