//
//  ControlViewDelegate.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

protocol ControlViewDelegate: AnyObject {
    
    func didPressLeft()
    
    func didReleaseLeft()
    
    func didPressRight()
    
    func didReleaseRight()
}
