//
//  StatefulViewController.swift
//  App
//
//  Created by Pranjal Satija on 1/22/18.
//  Copyright © 2018 Pranjal Satija. All rights reserved.
//

protocol StatefulViewController {
    associatedtype StateManager
    var stateManager: StateManager { get set }
}

protocol StateManager {
    associatedtype State
    mutating func update(for state: State)
}
