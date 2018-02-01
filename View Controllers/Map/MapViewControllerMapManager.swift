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
            let events = cluster.annotations.flatMap { ($0 as? EventAnnotation)?.event }

            if events.count == 1 {
                mapViewController.present(EventDetailViewController.make({
                    $0.event = events.first
                }), animated: true)
            } else {
                let camera = mapView.cameraThatFitsCluster(cluster, edgePadding: UIEdgeInsets(top: 48, left: 48, bottom: 48, right: 48))
                mapView.setCamera(camera, animated: true)
            }
        } else if let userLocation = annotation as? MGLUserLocation {
            let closestAnnotation = mapView.annotations?.sorted {
                $0.coordinate.distance(from: userLocation.coordinate) < $1.coordinate.distance(from: userLocation.coordinate)
            }.first

            if let closestAnnotation = closestAnnotation {
                self.mapView(mapView, didSelect: closestAnnotation)
            }
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
