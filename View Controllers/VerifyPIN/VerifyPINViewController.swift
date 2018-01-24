//
//  VerifyPinViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UIKit

final class VerifyPINViewController: UIViewController, ViewControllerMakeable {
    var user: User!

    @IBOutlet var pinTextField: TextField!
    @IBOutlet var verifyPINButton: Button!
}

extension VerifyPINViewController {
    @IBAction fileprivate func verifyPINButtonPressed() {
        guard let pin = pinTextField.text else {
            pinTextField.showError(message: String.PlaceholderErrorText.invalidPIN)
            return
        }

        verifyPINButton.showLoading()
        user.verifyPIN(pin) {(error, wasVerified) in
            self.verifyPINButton.hideLoading()

            if let error = error as? User.Error, error == .invalidPIN {
                self.pinTextField.showError(message: String.PlaceholderErrorText.invalidPIN)
            } else if error != nil {
                self.showError()
            } else {
                //move to walkthrough
            }
        }
    }
}
