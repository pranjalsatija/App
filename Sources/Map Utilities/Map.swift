//
//  Map.swift
//  App
//
//  Created by Pranjal Satija on 1/23/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox

class Map: MGLMapView {
    @IBInspectable var shouldHideTelemetryInfo: Bool = false
    private(set) var hasShownUserLocation = false
}

extension Map {
    override func awakeFromNib() {
        super.awakeFromNib()

        if shouldHideTelemetryInfo {
            attributionButton.isHidden = true
        }

        let algorithm = CKNonHierarchicalDistanceBasedAlgorithm()
        algorithm.cellSize = 275

        clusterManager.algorithm = algorithm
        clusterManager.animationDuration = 0
        clusterManager.marginFactor = 1
    }

    func showUserLocation(zoomLevel: Double) {
        guard let location = userLocation?.coordinate else {
            return
        }

        setCenter(location, zoomLevel: zoomLevel, animated: true)
        hasShownUserLocation = true
    }

    func showUserLocationIfNecessary(zoomLevel: Double) {
        guard !hasShownUserLocation else {
            return
        }

        showUserLocation(zoomLevel: zoomLevel)
    }
}

extension Map {
    func display(_ events: [Event]) {
        let currentAnnotations = clusterManager.annotations.flatMap({ $0 as? EventAnnotation })
        let currentlyDisplayedEvents = currentAnnotations.map { $0.event }

        let annotationsToAdd = events.filter {(event) in
            !currentlyDisplayedEvents.contains { $0 == event }
        }.map {
            EventAnnotation(event: $0)
        }

        let annotationsToRemove = currentAnnotations.filter {(annotation) in
            !events.contains { $0 == annotation.event }
        }

        clusterManager.annotations += (annotationsToAdd as [MKAnnotation])
        clusterManager.annotations = clusterManager.annotations.flatMap {
            $0 as? EventAnnotation
        }.filter {
            !annotationsToRemove.contains($0)
        }
    }

    func dequeueEventAnnotationView() -> EventAnnotationView {
        if let annotationView = dequeueReusableAnnotationView(withIdentifier: EventAnnotationView.reuseIdentifier),
            let eventAnnotationView = annotationView as? EventAnnotationView {
            return eventAnnotationView
        } else {
            return EventAnnotationView(reuseIdentifier: EventAnnotationView.reuseIdentifier)
        }
    }

    func dequeueEventClusterAnnotationView() -> EventClusterAnnotationView {
        if let annotationView = dequeueReusableAnnotationView(withIdentifier: EventClusterAnnotationView.reuseIdentifier),
            let eventClusterAnnotationView = annotationView as? EventClusterAnnotationView {
            return eventClusterAnnotationView
        } else {
            return EventClusterAnnotationView(reuseIdentifier: EventClusterAnnotationView.reuseIdentifier)
        }
    }
}
