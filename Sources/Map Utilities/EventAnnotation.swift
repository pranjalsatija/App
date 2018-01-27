//
//  EventAnnotationView.swift
//  App
//
//  Created by Pranjal Satija on 1/25/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox

public class EventAnnotation: NSObject, MKAnnotation, MGLAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var event: Event!
    public var subtitle: String?
    public var title: String?

    public init(event: Event) {
        self.coordinate = CLLocationCoordinate2D(event.location)
        self.event = event
        self.subtitle = event.eventDescription
        self.title = event.title
    }
}
