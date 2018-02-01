//
//  ViewControllerMakeable.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UI

protocol ViewControllerMakeable {
    static func make(_ block: ((Self) -> Void)?) -> Self
}

extension ViewControllerMakeable where Self: UIViewController {
    static func make(_ block: ((Self) -> Void)? = nil) -> Self {
        let storyboard = UIStoryboard(name: String(describing: Self.self), bundle: .main)
        let identifier = String(describing: Self.self)
        // swiftlint:disable:next force_cast
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        block?(viewController)
        return viewController
    }
}
