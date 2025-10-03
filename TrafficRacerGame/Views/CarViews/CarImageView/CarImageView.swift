//
//  CarImageView.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 03.10.2025.
//

import UIKit

class CarImageView: UIImageView, Car {
    
    private let carImageNames = (0...18).map { "car\($0)" }
    
    func place(on view: UIView) {
        guard let imageName = carImageNames.randomElement() else { return }
        guard let image = UIImage(named: imageName) else { return }
        self.image = image
        
        let size = image.size
        frame.size = size
        
        view.addSubview(self)
    }
    
    func restart() {
        
        removeFromSuperview()
    }
}
