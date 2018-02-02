//
//  MapViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox
import UI

final class MapViewController: UIViewController, ViewControllerMakeable {
    var events = [Event]()
    private var mapManager: MapViewControllerMapManager!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet var map: Map!
    @IBOutlet var statusLabel: UILabel!
}

extension MapViewController {
    override func viewDidLoad() {
        mapManager = MapViewControllerMapManager()
        mapManager.mapViewController = self
        map.delegate = mapManager
        beginVisitTracking()
    }

    private func beginVisitTracking() {
        LocationManager.shared.startLocationUpdates(shouldUpdateImmediately: true, distanceFilter: 25) {(locations) in
            guard let location = locations.first else {
                return
            }

            User.current.location.update(location)
            self.events.filter(User.current.isAt).forEach { User.current.registerVisit(with: $0) }
        }
    }
}

extension MapViewController {
    @IBAction func currentLocationButtonPressed() {
        map.showUserLocation(zoomLevel: map.zoomLevel)
    }

    @IBAction func myProfileButtonPressed() {
        present(ViewProfileViewController.make({
            $0.user = .current
        }), animated: true)
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
