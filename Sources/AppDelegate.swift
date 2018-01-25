//
//  AppDelegate.swift
//  App
//
//  Created by Pranjal Satija on 1/21/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        Core.initialize(withAppID: "mark", serverURL: "https://api.mark.events/parse")

        if User.current != nil {
            window?.rootViewController = MapViewController.make()
        }
    }
}
