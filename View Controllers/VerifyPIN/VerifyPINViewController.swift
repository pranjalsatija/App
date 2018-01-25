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
    @IBAction func verifyPINButtonPressed() {
        guard let pin = pinTextField.text else {
            pinTextField.showError(message: String.PlaceholderErrorText.invalidPIN)
            return
        }

        verifyPINButton.showLoading()
        user.verifyPIN(pin) {(error, _) in
            self.verifyPINButton.hideLoading()

            if let error = error as? User.Error, error == .invalidPIN {
                self.pinTextField.showError(message: String.PlaceholderErrorText.invalidPIN)
            } else if error != nil {
                self.showError()
            } else {
                let walkthrough = WalkthroughViewController.make()
                walkthrough.onCompletion {
                    walkthrough.present(MapViewController.make(), animated: true)
                }

                self.present(walkthrough, animated: true)
            }
        }
    }
}
