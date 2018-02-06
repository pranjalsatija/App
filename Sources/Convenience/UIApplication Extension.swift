//
//  Settings.swift
//  App
//
//  Created by Pranjal Satija on 2/5/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UIKit

extension UIApplication {
    var didShowNoEventsAlert: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "didShowNoEventsAlert")
        } set {
            UserDefaults.standard.set(newValue, forKey: "didShowNoEventsAlert")
        }
    }
}
