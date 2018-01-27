//
//  EventClusterAnnotationView.swift
//  App
//
//  Created by Pranjal Satija on 1/26/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox
import UIKit

class EventClusterAnnotationView: MGLAnnotationView {
    static let reuseIdentifier = "EventClusterAnnotationView"

    var count: Int! {
        didSet {
            configure()
        }
    }

    private var countLabel: UILabel!
}

extension EventClusterAnnotationView {
    func configure() {
        func configureFrame() {
            backgroundColor = .clear
            clipsToBounds = true
            frame.size = CGSize(width: 44, height: 44)
            layer.cornerRadius = min(frame.width, frame.height) / 2
            layer.drawsAsynchronously = true
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 1, height: 1)
            layer.shadowOpacity = 0.1
            layer.shadowRadius = 3
        }

        func configureCountLabel() {
            countLabel = UILabel()
            countLabel.backgroundColor = .base
            countLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            countLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            countLabel.text = String(count)
            countLabel.textAlignment = .center
            countLabel.textColor = .white
            addSubview(countLabel)
        }

        configureFrame()
        configureCountLabel()
    }
}
