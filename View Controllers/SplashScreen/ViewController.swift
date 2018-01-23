//
//  ViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UIKit

final class SplashScreenViewController: UIViewController, ViewControllerMakeable, StatefulViewController {
    var stateManager = StateManager()

    @IBOutlet var getStartedButton: RoundedButton!
    @IBOutlet var phoneNumberTextField: UITextField!
}

extension SplashScreenViewController {
    @IBAction fileprivate func getStartedButtonPressed() {
        guard let phoneNumber = phoneNumberTextField.text else {
            stateManager.update(for: .invalidPhoneNumber)
            return
        }

        stateManager.update(for: .loading)

        User.sendPIN(to: phoneNumber) {(error, user) in
            if let error = error as? User.Error, error == .invalidPhoneNumber {
                self.stateManager.update(for: .invalidPhoneNumber)
            } else if let error = error {
                //show error
            } else {
                // move on
            }
        }

        /*User.sendPIN(to: phoneNumber).onSuccess {(user) in
            let verifyPINViewController = VerifyPINViewController.make {
                $0.user = user
                $0.phoneNumber = phoneNumber
            }

            self.present(verifyPINViewController, animated: true)
            }.onError {(error) in
                if let error = error as? User.DataValidationError, error == .invalidPhoneNumber {
                    self.updateUI(for: .invalidPhoneNumber)
                } else {
                    self.present(Alert.makeErrorAlert(withMessage: AlertMessage.sendPINFailed), animated: true)
                    self.updateUI(for: .waitingForPhoneNumber)
                }
        }*/
    }
}
