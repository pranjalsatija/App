//
//  ProvideFeedbackPage.swift
//  App
//
//  Created by Pranjal Satija on 2/2/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

class ProvideFeedbackPage: UIViewController {
    private var didShakeHandler: (() -> Void)?
}

extension ProvideFeedbackPage {
    override func viewDidLoad() {
        Core.disableBugReporting()
    }

    func onShake(_ block: @escaping () -> Void) {
        didShakeHandler = block
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        Core.enableBugReporting()
        didShakeHandler?()
    }
}
