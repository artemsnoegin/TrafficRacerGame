//
//  ControlView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 09.09.2025.
//

import UIKit

class ControlView: UIView {
    
    weak var delegate: ControlViewDelegate?
    
    override func didMoveToSuperview() {
        guard let superview = superview else { return }
        
        let leftTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressLeft(_:)))
        leftTapGesture.minimumPressDuration = 0
        
        let rightTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressRight(_:)))
        rightTapGesture.minimumPressDuration = 0
        
        let leftButtonView = UIView()
        leftButtonView.frame.size = CGSize(width: superview.frame.width / 2, height: superview.frame.height / 2)
        leftButtonView.frame.origin = CGPoint(x: 0, y: superview.frame.height / 2)
        leftButtonView.addGestureRecognizer(leftTapGesture)
        superview.addSubview(leftButtonView)
        
        let rightButtonView = UIView()
        rightButtonView.frame.size = CGSize(width: superview.frame.width / 2, height: superview.frame.height / 2)
        rightButtonView.frame.origin = CGPoint(x: superview.frame.width / 2, y: superview.frame.height / 2)
        rightButtonView.addGestureRecognizer(rightTapGesture)
        superview.addSubview(rightButtonView)
    }
    
    @objc private func pressLeft(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            delegate?.leftIsHeld()
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            delegate?.leftHasBeenReleased()
        }
    }
    
    @objc private func pressRight(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            delegate?.rightIsHeld()
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            delegate?.rightHasBeenReleased()
        }
    }
    
}
