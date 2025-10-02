//
//  EnemyImageView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

import UIKit

class EnemyImageView: UIImageView {
    
    private let carNames = (0...18).map { "car\($0)" }
    
    func restart() {
        
        removeFromSuperview()
    }
    
    func place(on view: UIView) {
        guard let name = carNames.randomElement() else { return }
        guard let image = UIImage(named: name) else { return }
        self.image = image
        
        let enemySize = image.size
        frame.size = enemySize
        
        frame.origin.y = -enemySize.height
        
        let minX: CGFloat = 0
        let maxX: CGFloat = view.frame.width - enemySize.width
        center.x = CGFloat.random(in: minX...maxX)
        
        view.addSubview(self)
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
