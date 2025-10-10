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
    
    private var speed: CGFloat = 6
    
    private let scoreLabel = UILabel()
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundView)
        
        view.addSubview(controlView)
        controlView.delegate = playerImageView

        presentWelcomeAlert()
        addScoreLabel()
        addPauseButton()
    }
    
    private func addPauseButton() {
        
        let pauseButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"), style: .plain, target: self, action: #selector(pause))
        pauseButton.tintColor = .white
        navigationItem.rightBarButtonItem = pauseButton
    }
    
    private func addScoreLabel() {
        
        scoreLabel.text = String(score)
        scoreLabel.font = .preferredFont(forTextStyle: .largeTitle)
        scoreLabel.textColor = .white
        
        navigationController?.navigationBar.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        if let navigationBar = navigationController?.navigationBar {
            
            NSLayoutConstraint.activate([
                scoreLabel.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16),
                scoreLabel.topAnchor.constraint(equalTo: navigationBar.safeAreaLayoutGuide.topAnchor)
            ])
        }
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
            enemy.delegate = self
            
            enemies.append(enemy)
        }
    }
    
    @objc func gameLoop() {
        
        backgroundView.move(speed: speed)
        
        playerImageView.move(speed: speed)
        
        for enemy in enemies {
            
            enemy.move(speed: speed)
            
            if enemy.frame.insetBy(dx: 4, dy: 4).intersects(playerImageView.frame.insetBy(dx: 4, dy: 4)) {
                gameOver()
                break
            }
        }
    }
    
    @objc private func pause() {
        
        let currentSpeed = speed
        speed = 0
        
        let alert = UIAlertController(title: "Pause", message: nil, preferredStyle: .alert)
        
        let resume = UIAlertAction(title: "Resume", style: .cancel) { _ in
            self.speed = currentSpeed
        }
        alert.addAction(resume)
        
        present(alert, animated: true)
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
        
        speed = 6
        score = 0
        scoreLabel.text = String(score)
        
        startGameLoop()
    }
}

extension GameViewController: EnemyCarViewDelegate {
    
    func didNotCrash() {
        score += 1
        scoreLabel.text = String(score)
        
        if score % 10 == 0 {
            speed += 0.1
            print(speed)
        }
    }
}
