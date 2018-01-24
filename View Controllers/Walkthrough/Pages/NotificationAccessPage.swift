//
//  NotificationAccessPage.swift
//  App
//
//  Created by Pranjal Satija on 1/24/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UIKit

class NotificationAccessPage: UIViewController {
    typealias AuthorizationStatusChangeHandler = (Swift.Error?, Bool) -> Void
    private var authorizationStatusChangeHandler: AuthorizationStatusChangeHandler?
}

extension NotificationAccessPage {
    func onAuthorizationStatusChange(_ block: @escaping AuthorizationStatusChangeHandler) {
        authorizationStatusChangeHandler = block
    }

    @IBAction func enableNotificationsButtonPressed() {
        NotificationManager.requestAuthorization {(error, wasGrantedAuthorization) in
            self.authorizationStatusChangeHandler?(error, wasGrantedAuthorization)
        }
    }

    @IBAction func skipButtonPressed() {
        authorizationStatusChangeHandler?(nil, false)
    }
}
