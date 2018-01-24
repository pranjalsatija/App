//
//  Map.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Mapbox

class Map: MGLMapView {
    @IBInspectable var shouldHideTelemetryInfo: Bool = false
    private var hasShownUserLocation = false

    override func awakeFromNib() {
        super.awakeFromNib()

        if shouldHideTelemetryInfo {
            attributionButton.isHidden = true
        }
    }

    func showUserLocationIfNecessary() {
        guard !hasShownUserLocation else {
            return
        }

        showUserLocation()
    }

    func showUserLocation() {
        guard let location = userLocation?.coordinate else {
            return
        }

        setCenter(location, animated: true)
        hasShownUserLocation = true
    }
}
