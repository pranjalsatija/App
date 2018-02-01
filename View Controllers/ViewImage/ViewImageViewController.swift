//
//  ViewImageViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/31/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import UI

final class ViewImageViewController: UIViewController, ViewControllerMakeable {
    var image: UIImage!

    @IBOutlet var imageView: UIImageView!

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewImageViewController {
    override func viewDidLoad() {
        imageView.image = image
    }
}

extension ViewImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
