//
//  BackgroundView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 02.10.2025.
//

import UIKit

class BackgroundView: UIView, Movable {
    
    private let bg1 = UIImageView()
    private let bg2 = UIImageView()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superview = superview else { return }
        frame = superview.frame
        
        bg1.frame = frame
        addSubview(bg1)
        
        bg2.frame = frame
        bg2.frame.origin.y = -frame.height
        addSubview(bg2)
        
        if let roadImage = UIImage(named: "road") {
            bg1.image = roadImage
            bg2.image = roadImage
        }
    }
    
    func move(speed: CGFloat) {
        
        bg1.frame.origin.y += speed / 2
        bg2.frame.origin.y += speed / 2
        
        if bg1.frame.origin.y >= frame.height {
            bg1.frame.origin.y = bg2.frame.origin.y - bg1.frame.height
        }
        
        if bg2.frame.origin.y >= frame.height {
            bg2.frame.origin.y = bg1.frame.origin.y - bg2.frame.height
        }
    }
}
