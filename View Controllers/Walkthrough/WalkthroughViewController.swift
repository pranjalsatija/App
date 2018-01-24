//
//  WalkthroughViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UIKit

final class WalkthroughViewController: UIPageViewController, ViewControllerMakeable {
    var pages: [UIViewController]!
}

extension WalkthroughViewController {
    override func viewDidLoad() {
        //swiftlint:disable:next force_cast
        let notificationPage = makeViewController(withIdentifier: "Walkthrough.Notifications") as! NotificationAccessPage
        notificationPage.onAuthorizationStatusChange(notificationAuthorizationStatusChanged)

        pages = [
            makeViewController(withIdentifier: "Walkthrough.Welcome"),
            notificationPage,
            makeViewController(withIdentifier: "Walkthrough.Location")
        ]

        setViewControllers([pages.first!], direction: .forward, animated: true)

        dataSource = self
    }

    func notificationAuthorizationStatusChanged(error: Error?, wasAuthorized: Bool) {
        guard let first = viewControllers?.first, let index = pages.index(of: first) else {
            return
        }

        if index >= pages.endIndex - 1 {
            return
        } else {
            setViewControllers([pages[index + 1]], direction: .forward, animated: true)
        }
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

extension WalkthroughViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let index = pages.index(of: viewController) else {
            return nil
        }

        if index <= pages.startIndex {
            return nil
        } else {
            return pages[index - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = pages.index(of: viewController) else {
            return nil
        }

        if index >= pages.endIndex - 1 {
            return nil
        } else {
            return pages[index + 1]
        }
    }
}
