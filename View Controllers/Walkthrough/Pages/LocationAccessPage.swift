//
//  LocationAccessPage.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

class LocationAccessPage: UIViewController {
    typealias AuthorizationStatusChangeHandler = (CLAuthorizationStatus) -> Void
    private var authorizationStatusChangeHandler: AuthorizationStatusChangeHandler?
    private var shouldOpenSettings = false


    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var enableLocationAccessButton: UIButton!
}

extension LocationAccessPage {
    func onAuthorizationStatusChange(_ block: @escaping AuthorizationStatusChangeHandler) {
        authorizationStatusChangeHandler = block
    }

    @IBAction func enableLocationButtonPressed() {
        guard !shouldOpenSettings else {
            UIApplication.shared.openSettings()
            return
        }

        LocationManager.shared.requestWhenInUseAuthorization {(status) in
            if status == .denied {
                self.titleLabel.text = String.TitleText.locationRequired
                self.messageLabel.text = String.MessageText.locationRequired
                self.shouldOpenSettings = true
            }

            self.authorizationStatusChangeHandler?(status)
        }
    }
}
