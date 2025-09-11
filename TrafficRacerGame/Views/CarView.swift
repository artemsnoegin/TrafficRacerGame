//
//  CarView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 09.09.2025.
//

import UIKit

class CarView: UIView {

    init(color: UIColor) {
        super.init(frame: .zero)
        
        frame.size = CGSize(width: 60, height: 60)
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CarPlayer: CarView, ControlViewDelegate {

    enum Direction {
        case left
        case right
    }
    
    var direction: Direction?
    var displayLink: CADisplayLink?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = superview else { return }
        
        frame.origin = CGPoint(x: superview.frame.width / 2 - 30, y: superview.frame.height - superview.safeAreaInsets.bottom - 60)
    }
    
    func startMoving() {
        displayLink = CADisplayLink(target: self, selector: #selector(moveCar))
        displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
    }
    
    func stopMoving() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func moveCar() {
        guard let superview = superview else { return }
        
        if frame.origin.x > 0 {
            if direction == .left {
                center.x -= 10
            }
        }
        if center.x < superview.frame.width {
            if direction == .right {
                center.x += 10
            }
        }
    }
    
    func leftIsHeld() {
        direction = .left
        startMoving()
    }
    
    func leftHasBeenReleased() {
        direction = .none
        stopMoving()
    }
    
    func rightIsHeld() {
        direction = .right
        startMoving()
    }
    
    func rightHasBeenReleased() {
        direction = .none
        stopMoving()
    }
    
}
