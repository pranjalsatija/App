//
//  ViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

final class SplashScreenViewController: UIViewController, ViewControllerMakeable {
    @IBOutlet var getStartedButton: Button!
    @IBOutlet var phoneNumberTextField: TextField!
}

extension SplashScreenViewController {
    @IBAction func sendPINButtonPressed() {
        guard let phoneNumber = phoneNumberTextField.text else {
            self.phoneNumberTextField.showError(message: String.PlaceholderErrorText.invalidPhoneNumber)
            return
        }

        getStartedButton.showLoading()

        User.sendPIN(to: phoneNumber) {(error, user) in
            self.getStartedButton.hideLoading()

            if let error = error as? User.Error, error == .invalidPhoneNumber {
                self.phoneNumberTextField.showError(message: String.PlaceholderErrorText.invalidPhoneNumber)
            } else if error != nil {
                self.showError()
            } else if let user = user {
                self.present(VerifyPINViewController.make({
                    $0.user = user
                }), animated: true)
            } else if phoneNumber == String.DummyAccount.phoneNumber {
                User.logInWithUsername(inBackground: phoneNumber, password: String.DummyAccount.password) {(error, _) in
                    if error != nil {
                        self.showError()
                    } else {
                        self.present(MapViewController.make(), animated: true)
                    }
                }
            }
        }
    }
}
