//
//  EventClusterAnnotationView.swift
//  App
//
//  Created by Pranjal Satija on 1/26/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox
import UI

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
            frame.size = CGSize(width: 44, height: 44)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.shadowOpacity = 0.25
            layer.shadowRadius = 4
        }

        func configureCountLabel() {
            countLabel = UILabel()
            countLabel.backgroundColor = .base
            countLabel.clipsToBounds = true
            countLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            countLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            countLabel.layer.cornerRadius = min(frame.width, frame.height) / 2
            countLabel.text = String(count)
            countLabel.textAlignment = .center
            countLabel.textColor = .white
            addSubview(countLabel)
        }

        configureFrame()
        configureCountLabel()
    }
}
