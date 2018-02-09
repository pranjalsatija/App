//
//  EventListViewController.swift
//  App
//
//  Created by Pranjal Satija on 2/9/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import UI

final class EventListViewController: UIViewController, ViewControllerMakeable {
    var events = [Event]()
    var location: LocationType?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var eventsTableView: UITableView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension EventListViewController {
    override func viewDidLoad() {
        if let location = location {
            // TODO: Reverse Geocode location as an address
        }
    }
}

extension EventListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier) as! EventCell
        cell.configure(with: events[indexPath.row])
        return cell
    }
}
