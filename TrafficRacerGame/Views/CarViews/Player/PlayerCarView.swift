//
//  PlayerCarView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

import UIKit

class PlayerCarView: CarImageView, Movable, Controllable {
    
    var isMovingLeft = false
    var isMovingRight = false
    
    override func place(on view: UIView) {
        super.place(on: view)
        
        let playerViewStartPoint = CGPoint(x: view.center.x - frame.size.width / 2,
                                           y: view.frame.height - frame.height * 1.5)
        frame.origin = playerViewStartPoint

        transform = CGAffineTransform(rotationAngle: .pi)
    }
    
    func move(speed: CGFloat) {
        guard let superview = superview else { return }
        
        if isMovingLeft {
            center.x = max(frame.width / 2, center.x - speed)
        }
        if isMovingRight {
            center.x = min(superview.frame.width - frame.width / 2, center.x + speed)
        }
    }
    
    override func restart() {
        super.restart()
        
        isMovingLeft = false
        isMovingRight = false
    }
}

extension PlayerCarView: ControlViewDelegate {

    func didPressLeft() {
        isMovingLeft = true
    }
    
    func didReleaseLeft() {
        isMovingLeft = false
    }
    
    func didPressRight() {
        isMovingRight = true
    }
    
    func didReleaseRight() {
        isMovingRight = false
    }
}
