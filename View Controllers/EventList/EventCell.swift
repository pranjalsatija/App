//
//  EventCell.swift
//  App
//
//  Created by Pranjal Satija on 2/9/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

class EventCell: UITableViewCell {
    static let reuseIdentifier = "EventCell"

    var event: Event!

    @IBOutlet var eventCategoryImageView: UIImageView!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventDescriptionLabel: UILabel!
}

extension EventCell {
    func configure(with event: Event) {
        guard let title = event.title, let description = event.eventDescription else {
            return
        }

        self.event = event

        event.category.getIconImage {(_, image) in
            self.eventCategoryImageView.image = image
        }

        eventTitleLabel.text = title
        eventDescriptionLabel.text = "\(event.startDate.relativeDescription) - \(description)"
        eventDescriptionLabel.boldSubstring(event.startDate.relativeDescription)
    }
}
