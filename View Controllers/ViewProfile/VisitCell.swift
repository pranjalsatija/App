//
//  VisitCell.swift
//  App
//
//  Created by Pranjal Satija on 2/1/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

class VisitCell: UITableViewCell {
    static let reuseIdentifier = "VisitCell"

    var visit: Visit!

    @IBOutlet var eventCategoryImageView: UIImageView!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var visitTimeLabel: UILabel!
}

extension VisitCell {
    func configure(visit: Visit) {
        guard let eventTitle = visit.event.title, let visitTime = visit.createdAt else {
            return
        }

        self.visit = visit

        visit.event.category.getIconImage {(_, image) in
            self.eventCategoryImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }

        eventTitleLabel.text = eventTitle
        visitTimeLabel.text = "Visited \(visitTime.relativeDescription)"
    }
}
