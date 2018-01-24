//
//  RoundedButton.swift
//  App
//
//  Created by Pranjal Satija on 1/21/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UIKit

@IBDesignable class Button: UIButton {
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

    open func performSetup() {
        layer.cornerRadius = 5
    }
}

extension Button {
    func showLoading(withColor color: UIColor? = nil) {
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.color = color ?? tintColor
        loadingIndicator.center = center
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()

        superview?.addSubview(loadingIndicator)
        isHidden = true
    }

    func hideLoading() {
        loadingIndicator.removeFromSuperview()
        loadingIndicator = nil
        isHidden = false
    }
}
