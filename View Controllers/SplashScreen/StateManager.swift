//
//  StateManager.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

struct SplashScreenViewControllerStateManager: StateManager {
    var viewController: SplashScreenViewController?
    var state: State?

    mutating func update(for state: State) {
        guard let viewController = viewController else {
            return
        }

        self.state = state
        switch state {
        case .invalidPhoneNumber:
            //viewController.phoneNumberTextField.showErr
            break

        case .loading:
            viewController.getStartedButton.showLoading()
        }
    }
}

extension SplashScreenViewControllerStateManager {
    enum State {
        case invalidPhoneNumber
        case loading
    }
}

extension SplashScreenViewController {
    typealias StateManager = SplashScreenViewControllerStateManager
}
