//
//  MapViewControllerMapManager.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox

class MapViewControllerMapManager: NSObject {
    weak var mapViewController: MapViewController!
}

extension MapViewControllerMapManager: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        mapViewController.map.showUserLocationIfNecessary(zoomLevel: 11)
    }

    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        mapViewController.updateStatus(.loading)

        Event.getRelevantEvents(in: mapView.visibleCoordinateBounds, categories: nil) {(error, events) in
            if error != nil {
                self.mapViewController.updateStatus(.error)
            } else if let events = events {
                self.mapViewController.events = events
                self.mapViewController.map.display(events)
                self.mapViewController.updateStatus(.ready)
                self.mapViewController.map.clusterManager.updateClustersIfNeeded()
            }
        }
    }

    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        if let cluster = annotation as? CKCluster {
            print(cluster.annotations.flatMap { $0 as? EventAnnotation }.map { $0.event.title })
        } else if let event = annotation as? EventAnnotationView {
            print(event.event.title)
        }
    }

    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        guard let cluster = annotation as? CKCluster else {
            return nil
        }

        let events = cluster.annotations.flatMap { $0 as? EventAnnotation }.flatMap { $0.event }

        if events.count == 1 {
            let annotationView = mapViewController.map.dequeueEventAnnotationView()
            annotationView.event = events.first
            return annotationView
        } else {
            let annotationView = mapViewController.map.dequeueEventClusterAnnotationView()
            annotationView.count = events.count
            return annotationView
        }
    }
}
