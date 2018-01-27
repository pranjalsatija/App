//
//  MapViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox
import UIKit

final class MapViewController: UIViewController, ViewControllerMakeable {
    var events = [Event]()
    private var mapManager: MapViewControllerMapManager!

    @IBOutlet var map: Map!
    @IBOutlet var statusLabel: UILabel!
}

extension MapViewController {
    override func viewDidLoad() {
        mapManager = MapViewControllerMapManager()
        mapManager.mapViewController = self
        map.delegate = mapManager

        beginLocationUpdates()
    }

    private func beginLocationUpdates() {
        LocationManager.shared.startLocationUpdates {(locations) in
            guard let location = locations.first else {
                return
            }

            User.current.location.update(location)
            self.events.filter {
                User.current.isAt($0)
            }.forEach {
                User.current.registerVisit(with: $0)
            }
        }
    }
}

extension MapViewController {
    @IBAction func currentLocationButtonPressed() {
        map.showUserLocation(zoomLevel: map.zoomLevel)
    }
}

extension MapViewController {
    enum Status {
        case error
        case loading
        case ready
    }

    func updateStatus(_ status: Status) {
        switch status {
        case .error:
            statusLabel.text = String.StatusMessage.error

        case .loading:
            statusLabel.text = String.StatusMessage.loading

        case .ready:
            statusLabel.text = String.StatusMessage.ready
        }
    }
}
