//
//  EnemyCarView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

import UIKit

class EnemyCarView: CarImageView, Movable {
    
    override func place(on view: UIView) {
        super.place(on: view)
        
        frame.origin.y = -frame.height
        
        let minX: CGFloat = 0
        let maxX: CGFloat = view.frame.width - frame.width
        center.x = CGFloat.random(in: minX...maxX)
    }
    
    func move(speed: CGFloat) {
        guard let superview = superview else { return }
        
        frame.origin.y += speed
        
        if frame.origin.y > superview.frame.height {
            removeFromSuperview()
            place(on: superview)
        }
    }
}
