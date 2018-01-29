//
//  Strings.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

// MARK: UIAlertController
extension String {
    struct AlertActionTitle {
        static let dismiss = "Dismiss"
    }

    struct AlertMessage {
        static let errorOccurred = "An error occurred."
    }

    struct AlertTitle {
        static let errorOccurred = "Error"
    }

    struct ButtonText {
        static let openSettings = "OPEN SETTINGS"
    }

    struct MessageText {
        static let locationRequired = "Your location is required to use mark. Please use Settings to enable location access."
    }

    struct PlaceholderErrorText {
        static let invalidPIN = "Invalid PIN"
        static let invalidPhoneNumber = "Invalid Phone Number"
    }

    struct TitleText {
        static let locationRequired = "Location Required"
    }

    struct StatusMessage {
        static let error = "Error"
        static let loading = "Loading..."
        static let ready = "mark"
    }
}
