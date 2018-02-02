//
//  AppDelegate.swift
//  App
//
//  Created by Pranjal Satija on 1/21/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        Core.initialize(withAppID: "mark", serverURL: "https://api.mark.events/parse", instabugToken: "c560ab3f2692fd5e5ddabe768d6416a7")

        if User.current != nil {
            window?.rootViewController = MapViewController.make()
            User.current?.startSession()
        }

        UIApplication.shared.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        registerForNotifications(withToken: deviceToken)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        User.current?.startSession()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        User.current?.endLatestSession()
    }
}
