//
//  AppDelegate.swift
//  Greegodriverapp
//
//  Created by Harshal Shah on 4/6/18.
//  Copyright © 2018 Harshal Shah. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        IQKeyboardManager.sharedManager().enable = true
       /*if let key = UserDefaults.standard.object(forKey: "profile_status"){
            var status = UserDefaults.standard.string(forKey:"profile_status")
          if(status == "2"){
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "DrivershippingaddViewController")as! DrivershippingaddViewController
                
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
            }
            else if(status == "3"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "DriverdocumentViewController")
            navigationController.pushViewController(initialViewController, animated: true)
           self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
                /*self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "DriverdocumentViewController")as! DriverdocumentViewController
                
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()*/
          }else if(status == "5"){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "DrivertypeViewController")
            navigationController.pushViewController(initialViewController, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
        
            }
          else if(status == "6"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "DriverprofileViewController")
            navigationController.pushViewController(initialViewController, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            
            }
        }*/
        
      
        GMSServices.provideAPIKey("AIzaSyCTYoZFJBLdRwY9QdneWtG4LvwVuzSw_AM")
        GMSPlacesClient.provideAPIKey("AIzaSyAyvGa8vAvoiFNgAUo8QW7zh8qJbBn8X8o")
        DispatchQueue.main.async {
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()

        }
        return true
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let characterSet = CharacterSet(charactersIn: "<>")
                let deviceTokenString = deviceToken.description.trimmingCharacters(in: characterSet).replacingOccurrences(of: " ", with: "");
                print(deviceTokenString)
        
                let user = UserDefaults.standard
                user.set(deviceTokenString, forKey: "devicetoken")
                user.synchronize()
        
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != UIUserNotificationType() {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error!) {
        print(error.localizedDescription)
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
    class func hasConnectivity() -> Bool {
        
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
        
    }

}

