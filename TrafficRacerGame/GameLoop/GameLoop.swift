//
//  GameLoop.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 11.10.2025.
//

import UIKit

class GameLoop {
    
    weak var delegate: GameLoopDelegate?
    
    private var displayLink: CADisplayLink?
    
    func start() {
        
        displayLink = CADisplayLink(target: self, selector: #selector(run))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc private func run() {
        
        delegate?.isRunning()
    }
    
    func pause() {

        displayLink?.isPaused = true
    }
    
    func restart() {

        displayLink?.isPaused = false
    }
    
    func invalidate() {
        
        displayLink?.invalidate()
    }
}
