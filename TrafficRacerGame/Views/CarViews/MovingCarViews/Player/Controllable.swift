//
//  Controllable.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 03.10.2025.
//


protocol Controllable: AnyObject {
    
    var isMovingLeft: Bool { get }
    var isMovingRight: Bool { get }
}
