//
//  EventAnnotationView.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox
import UI

class EventAnnotationView: MGLAnnotationView {
    static let reuseIdentifier = "EventAnnotationView"

    var event: Event! {
        didSet {
            configure()
        }
    }

    private var iconImageView: UIImageView!
}

extension EventAnnotationView {
    func configure() {
        func configureFrame() {
            backgroundColor = .clear
            frame.size = CGSize(width: 44, height: 44)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.shadowOpacity = 0.25
            layer.shadowRadius = 4
        }

        func configureCategoryIconImageView() {
            iconImageView = UIImageView()
            iconImageView.backgroundColor = .base
            iconImageView.clipsToBounds = true
            iconImageView.contentMode = .center
            iconImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            iconImageView.layer.cornerRadius = min(frame.width, frame.height) / 2
            iconImageView.tintColor = .white

            event.category.getIconImage {(_, image) in
                self.iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
            }

            addSubview(iconImageView)
        }

        configureFrame()
        configureCategoryIconImageView()
    }
}
