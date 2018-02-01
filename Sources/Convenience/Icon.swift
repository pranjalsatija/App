//
//  Icon.swift
//  UI
//
//  Created by Pranjal Satija on 1/30/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

public enum Icon: String {
    case addPost
    case chevronRight
    case clock
    case currentLocation
    case dismiss
    case event
    case flashAuto
    case flashOff
    case flashOn
    case frontCamera
    case info
    case like
    case likeOutline
    case post
    case photoCamera
    case rearCamera
    case settings
    case social
    case subscribe
    case unsubscribe
    case user
    case venue
    case videoCamera
    case warning

    var image: UIImage! {
        return UIImage(named: rawValue)!
    }
}
