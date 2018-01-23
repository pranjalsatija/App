//
//  RoundedButton.swift
//  App
//
//  Created by Pranjal Satija on 1/21/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton {
    var loadingIndicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        performSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        performSetup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        performSetup()
    }
}

extension RoundedButton {
    func showLoading(withColor color: UIColor? = nil) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.tintColor = color ?? tintColor
        superview?.addSubview(activityIndicator)
        activityIndicator.center = center

        isHidden = true
    }

    func hideLoading() {
        loadingIndicator = nil
        isHidden = false
    }
}

extension RoundedButton {
    private func performSetup() {
        layer.cornerRadius = 5
    }
}
