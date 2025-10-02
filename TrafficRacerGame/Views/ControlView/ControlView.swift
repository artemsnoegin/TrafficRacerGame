//
//  ControlView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

import UIKit

class ControlView: UIView {
    
    weak var delegate: ControlViewDelegate?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addControlsOnView()
    }
    
    private func addControlsOnView() {
        guard let superview = superview else { return }
        frame = superview.frame
        
        let leftTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressLeft(_:)))
        leftTapGesture.minimumPressDuration = 0
        
        let rightTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressRight(_:)))
        rightTapGesture.minimumPressDuration = 0
        
        let leftButtonView = UIView()
        leftButtonView.frame.size = CGSize(width: frame.width / 2, height: frame.height / 2)
        leftButtonView.frame.origin = CGPoint(x: 0, y: frame.height / 2)
        leftButtonView.addGestureRecognizer(leftTapGesture)
        addSubview(leftButtonView)
        
        let rightButtonView = UIView()
        rightButtonView.frame.size = CGSize(width: frame.width / 2, height: frame.height / 2)
        rightButtonView.frame.origin = CGPoint(x: frame.width / 2, y: frame.height / 2)
        rightButtonView.addGestureRecognizer(rightTapGesture)
        addSubview(rightButtonView)
    }
    
    @objc func pressLeft(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            delegate?.didPressLeft()
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            delegate?.didReleaseLeft()
        }
    }

    @objc func pressRight(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            delegate?.didPressRight()
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            delegate?.didReleaseRight()
        }
    }
}
