//
//  GameViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class GameViewController: UIViewController {
 
    private var displayLink: CADisplayLink?
    
    private let carNames = (0...18).map { "car\($0)" }
    
    private let enemyImageView = UIImageView()
    
    private let backgroundView = BackgroundView()
    
    private let controlView = ControlView()
    
    private let playerImageView = PlayerImageView()
    
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
    
    // MARK: Enemy
    private func addEnemyOnView() {
        guard let enemyCarName = carNames.randomElement() else { return }
        guard let enemyCarImage = UIImage(named: enemyCarName) else { return }
        enemyImageView.image = enemyCarImage
        
        let enemySize = enemyCarImage.size
        enemyImageView.frame.size = enemySize
        
        enemyImageView.frame.origin.y = -enemySize.height
        
        let minX: CGFloat = 0
        let maxX: CGFloat = view.frame.width - enemySize.width
        enemyImageView.center.x = CGFloat.random(in: minX...maxX)
        
        view.addSubview(enemyImageView)
    }
    
    private func moveEnemy() {
        enemyImageView.frame.origin.y += speed
        
        if enemyImageView.frame.origin.y > view.frame.height {
            enemyImageView.removeFromSuperview()
            addEnemyOnView()
        }
    }
    
    // MARK: Game Logic
    private func startGameLoop() {
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .main, forMode: .default)
        
        playerImageView.place(on: view)
        
        addEnemyOnView()
    }
    
    @objc func gameLoop() {
        backgroundView.moveBackground(speed: speed)
        
        playerImageView.move(speed: speed)
        
        moveEnemy()
        
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
        
        enemyImageView.removeFromSuperview()
        
        startGameLoop()
    }
}
