//
//  PlayerImageView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

import UIKit

class PlayerImageView: UIImageView {
    
    private let carNames = (0...18).map { "car\($0)" }
    
    private var isMovingLeft = false
    private var isMovingRight = false
    
    func restart() {
        
        removeFromSuperview()
        
        isMovingLeft = false
        isMovingRight = false
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
    
    func place(on view: UIView) {
        
        guard let name = carNames.randomElement() else { return }
        
        guard let image = UIImage(named: name) else { return }
        self.image = image

        let playerSize = image.size
        
        frame.size = playerSize
        
        let playerViewStartPoint = CGPoint(x: view.center.x - playerSize.width / 2,
                                           y: view.frame.height - playerSize.height * 1.5)
        frame.origin = playerViewStartPoint

        transform = CGAffineTransform(rotationAngle: .pi)
        view.addSubview(self)
    }
}

extension PlayerImageView: ControlViewDelegate {

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
