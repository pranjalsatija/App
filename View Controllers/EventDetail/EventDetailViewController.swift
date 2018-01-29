//
//  EventDetailViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/26/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

final class EventDetailViewController: UIViewController, ViewControllerMakeable {
    var event: Event!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


    @IBOutlet var titleLabel: UILabel!
}

extension EventDetailViewController {
    override func viewDidLoad() {
        titleLabel.text = event.title
    }
}
