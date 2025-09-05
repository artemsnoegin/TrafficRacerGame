//
//  CustomButton.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class CustomButton: UIButton {
    
    let height: CGFloat = 60
    
    var title: String
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
        
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setTitle(title, for: .normal)
        backgroundColor = color
        titleLabel?.font = .systemFont(ofSize: 30, weight: .bold, width: .condensed)
        
        layer.cornerRadius = height / 2
        layer.borderWidth = 4
        layer.borderColor = UIColor.white.cgColor
        
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 1, height: 1.5)
    }
    
}
