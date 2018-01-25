//
//  WalkthroughViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import CoreLocation
import UIKit

final class WalkthroughViewController: UIPageViewController, ViewControllerMakeable {
    var pages: [UIViewController]!

    private var completionHandler: (() -> Void)?
}

extension WalkthroughViewController {
    override func viewDidLoad() {
        //swiftlint:disable:next force_cast
        let notificationPage = makeViewController(withIdentifier: "Walkthrough.Notifications") as! NotificationAccessPage
        notificationPage.onAuthorizationStatusChange(notificationAuthorizationStatusChanged)

        //swiftlint:disable:next force_cast
        let locationPage = makeViewController(withIdentifier: "Walkthrough.Location") as! LocationAccessPage
        locationPage.onAuthorizationStatusChange(locationAuthorizationStatusChanged)

        pages = [
            makeViewController(withIdentifier: "Walkthrough.Welcome"),
            notificationPage,
            locationPage
        ]

        setViewControllers([pages.first!], direction: .forward, animated: true)

        dataSource = self
    }

    func notificationAuthorizationStatusChanged(error: Error?, wasAuthorized: Bool) {
        guard let first = viewControllers?.first, let index = pages.index(of: first) else {
            return
        }

        if index >= pages.endIndex - 1 {
            completionHandler?()
        } else {
            setViewControllers([pages[index + 1]], direction: .forward, animated: true)
        }
    }

    func locationAuthorizationStatusChanged(status: CLAuthorizationStatus) {
        guard status != .notDetermined else {
            return
        }

        guard let first = viewControllers?.first, let index = pages.index(of: first) else {
            return
        }

        if index >= pages.endIndex - 1 {
            completionHandler?()
        } else {
            setViewControllers([pages[index + 1]], direction: .forward, animated: true)
        }
    }
}

extension WalkthroughViewController {
    func onCompletion(_ block: @escaping () -> Void) {
        completionHandler = block
    }
}

extension WalkthroughViewController {
    func makeViewController(withIdentifier identifier: String) -> UIViewController {
        let storyboardID = String(describing: WalkthroughViewController.self)
        let storyboard = UIStoryboard(name: storyboardID, bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }
}
