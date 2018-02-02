//
//  Strings.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

// MARK: UIAlertController
extension String {
    struct ActionSheetMessage {
        static let report = "Please pick a reason for reporting this event."
    }

    struct ActionSheetTitle {
        static let report = "Report Event"
    }

    struct AlertActionTitle {
        static let dismiss = "Dismiss"
    }

    struct AlertMessage {
        static let errorOccurred = "An error occurred. Please try again later."
        static let eventReported = "Thank you for reporting this event. Someone from our content moderation team has been alerted."
    }

    struct AlertTitle {
        static let errorOccurred = "Error"
        static let eventReported = "Event Reported"
    }

    struct ButtonText {
        static let getDirections = "GET DIRECTIONS"
        static let inviteFriends = "INVITE FRIENDS"
        static let openSettings = "OPEN SETTINGS"
        static let shareEvent = "SHARE EVENT"
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
