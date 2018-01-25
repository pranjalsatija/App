//
//  LocationAccessPage.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UIKit

class LocationAccessPage: UIViewController {
    typealias AuthorizationStatusChangeHandler = (CLAuthorizationStatus) -> Void
    private var authorizationStatusChangeHandler: AuthorizationStatusChangeHandler?
}

extension LocationAccessPage {
    func onAuthorizationStatusChange(_ block: @escaping AuthorizationStatusChangeHandler) {
        authorizationStatusChangeHandler = block
    }

    @IBAction func enableLocationButtonPressed() {
        LocationManager.shared.requestWhenInUseAuthorization {(status) in
            self.authorizationStatusChangeHandler?(status)
        }
    }
}
