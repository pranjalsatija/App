//
//  MGLCoordinateBounds+GeoBox.swift
//  App
//
//  Created by Pranjal Satija on 1/24/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

import Core
import Mapbox

extension MGLCoordinateBounds: GeoBox {
    public var northeast: LocationType {
        return ne
    }

    public var southwest: LocationType {
        return sw
    }
}
