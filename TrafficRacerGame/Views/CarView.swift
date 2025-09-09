//
//  CarView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 09.09.2025.
//

import UIKit

class CarView: UIView {
    
    var direction: Direction?

    init(color: UIColor) {
        super.init(frame: .zero)
        
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview = superview else { return }
        
        frame.size = CGSize(width: 60, height: 60)
        frame.origin = CGPoint(x: superview.frame.width / 2 - 30, y: superview.frame.height - superview.safeAreaInsets.bottom - 60)
    }
}

extension CarView {
    enum Direction {
        case left
        case right
    }
}
