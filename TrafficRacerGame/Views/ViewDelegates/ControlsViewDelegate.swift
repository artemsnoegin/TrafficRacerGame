//
//  ControlsViewDelegate.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 09.09.2025.
//

import UIKit

protocol ControlsViewDelegate: AnyObject {
    func leftIsHeld()
    func leftHasBeenReleased()
    func rightIsHeld()
    func rightHasBeenReleased()
}
