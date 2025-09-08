//
//  BackgroundRoadView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 08.09.2025.
//

import UIKit

class BackgroundRoadView: UIView {
    
    override func didMoveToSuperview() {
        drawBackground()
    }
    
    private func drawBackground() {
        guard let superview = superview else { return }
        
        frame = superview.frame
        
        backgroundColor = .systemGreen
        
        let roadSubview = UIView()
        roadSubview.backgroundColor = .systemGray4
        
        let roadWidth = frame.width / 1.3
        roadSubview.frame.size = CGSize(width: roadWidth, height: frame.height)
        roadSubview.frame.origin.x = (frame.width - roadWidth) / 2
        
        addSubview(roadSubview)
    }
    
}
