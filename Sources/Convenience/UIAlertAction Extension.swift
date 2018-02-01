//
//  UIAlertController Extension.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UI

extension UIAlertAction {
    static func dismiss(_ alert: UIAlertController) -> UIAlertAction {
        return UIAlertAction(title: String.AlertActionTitle.dismiss, style: .cancel) {(_) in
            alert.dismiss(animated: true)
        }
    }
}
