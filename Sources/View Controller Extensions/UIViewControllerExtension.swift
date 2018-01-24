//
//  UIViewControllerExtension.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UIKit

extension UIViewController {
    @IBAction func dismiss() {
        dismiss(animated: true)
    }

    @IBAction func endEditing() {
        view.endEditing(true)
    }

    func showAlert(withTitle title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach(alert.addAction)
        self.present(alert, animated: true, completion: nil)
    }

    func showError() {
        let alert = UIAlertController(
            title: String.AlertTitle.errorOccurred,
            message: String.AlertMessage.errorOccurred,
            preferredStyle: .alert
        )
        
        alert.addAction(.dismiss(alert))
        self.present(alert, animated: true, completion: nil)
    }
}
