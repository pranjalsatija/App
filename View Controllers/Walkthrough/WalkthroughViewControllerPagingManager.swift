//
//  WalkthroughViewControllerPagingManager.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UI

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
