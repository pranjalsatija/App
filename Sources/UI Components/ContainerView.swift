//
//  ContainerView.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UIKit

class ContainerView: UIView {
    private var observers = [Any]()

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

    deinit {
        observers.forEach(NotificationCenter.default.removeObserver(_:))
    }
}

extension ContainerView {
    private func performSetup() {
        let willShowObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main) {(notification) in

            guard
                let userInfo = notification.userInfo,
                let height = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
                let superview = self.superview,
                let yConstraint = superview.constraints.first(where: { $0.firstAttribute == .centerY })
                else {
                    return
            }

            let distanceFromBottom = superview.frame.height - (self.center.y + self.frame.height / 2)
            if distanceFromBottom < height {
                let newConstant = distanceFromBottom - height - 16
                UIView.animate(withDuration: 0.25) {
                    yConstraint.constant += newConstant
                    superview.layoutIfNeeded()
                }
            }
        }

        let willHideObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main) {(_) in
            let yConstraint = self.superview?.constraints.first(where: { $0.firstAttribute == .centerY })
            yConstraint?.constant = 0
            self.superview?.layoutIfNeeded()
        }

        observers.append(contentsOf: [willShowObserver, willHideObserver])
    }
}
