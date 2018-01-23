//
//  RoundedTextField.swift
//  App
//
//  Created by Pranjal Satija on 1/21/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UIKit

@IBDesignable class RoundedTextField: UITextField {
    @IBInspectable var horizontalPadding: CGFloat = 0
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            configureAttributedPlaceholder()
        }
    }

    @IBInspectable var verticalPadding: CGFloat = 0


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

extension RoundedTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + horizontalPadding,
                      y: bounds.origin.y + verticalPadding,
                      width: bounds.width - horizontalPadding * 2,
                      height: bounds.height - horizontalPadding * 2)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

extension RoundedTextField {
    private func configureAttributedPlaceholder() {
        guard let text = placeholder, let color = placeholderColor else {
            return
        }

        attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor: color])
    }

    private func performSetup() {
        layer.cornerRadius = 5
    }
}
