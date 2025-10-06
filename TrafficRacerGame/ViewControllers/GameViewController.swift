//
//  GameViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class GameViewController: UIViewController {
 
    private var displayLink: CADisplayLink?
    
    private let backgroundView = BackgroundView()
    
    private let controlView = ControlView()
    
    private let enemyImageView = EnemyCarView()
    private let playerImageView = PlayerCarView()
    
    private let speed: CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        
        view.addSubview(controlView)
        controlView.delegate = playerImageView

        presentWelcomeAlert()
    }
    
    private func presentWelcomeAlert() {
        let welcomeAlert = UIAlertController(title: "Welcome", message: nil, preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Start", style: .default) { _ in
            self.startGameLoop()
        }
        welcomeAlert.addAction(startAction)
        
        present(welcomeAlert, animated: true)
    }
    
    // MARK: Game Logic
    private func startGameLoop() {
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .main, forMode: .default)
        
        playerImageView.place(on: view)
        
        enemyImageView.place(on: view)
    }
    
    @objc func gameLoop() {
        backgroundView.move(speed: speed)
        
        playerImageView.move(speed: speed)
        
        enemyImageView.move(speed: speed)
        
        if enemyImageView.frame.intersects(playerImageView.frame) {
            gameOver()
            return
        }
    }
    
    private func gameOver() {
        displayLink?.invalidate()
        displayLink = nil
        
        let alert = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default) { _ in
            self.gameRestart()
        })
        
        present(alert, animated: true)
    }
    
    private func gameRestart() {
        
        playerImageView.restart()
        
        enemyImageView.restart()
        
        startGameLoop()
    }
}
