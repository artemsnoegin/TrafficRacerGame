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
    
    private let playerImageView = PlayerCarView()
    private var enemies: [EnemyCarView] = []
    
    private var enemySpawnTimer = Timer()
    
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
        
        enemySpawnTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(spawnEnemies), userInfo: nil, repeats: true)
        enemySpawnTimer.fire()
    }
    
    @objc private func spawnEnemies() {
        
        if enemies.count < 3 {
            
            let enemy = EnemyCarView()
            enemy.place(on: view)
            
            enemies.append(enemy)
        }
    }
    
    @objc func gameLoop() {
        
        backgroundView.move(speed: speed)
        
        playerImageView.move(speed: speed)
        
        for enemy in enemies {
            
            enemy.move(speed: speed)
            
            if enemy.frame.intersects(playerImageView.frame) {
                gameOver()
                break
            }
        }
    }
    
    private func gameOver() {
        displayLink?.invalidate()
        displayLink = nil
        
        enemySpawnTimer.invalidate()
        
        let alert = UIAlertController(title: "Game Over", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart", style: .default) { _ in
            self.gameRestart()
        })
        
        present(alert, animated: true)
    }
    
    private func gameRestart() {
        
        playerImageView.removeFromSuperview()
        
        enemies.forEach { $0.removeFromSuperview() }
        enemies.removeAll()
        
        startGameLoop()
    }
}
