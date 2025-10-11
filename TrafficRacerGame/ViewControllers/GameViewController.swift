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

        presentStartButtonAlert()
        addScoreLabel()
        addPauseButton()
    }
    
    private func addPauseButton() {
        
        let pauseButton = UIBarButtonItem(title: "Pause", style: .plain, target: self, action: #selector(pause))
        if let font = UIFont(name: "CyberpunkCraftpixPixel", size: UIFont.labelFontSize) {
            pauseButton.setTitleTextAttributes([.font: font], for: .normal)
            pauseButton.setTitleTextAttributes([.font: font], for: .highlighted)
        }
        pauseButton.tintColor = .white
        pauseButton.isHidden = true
        
        navigationItem.rightBarButtonItem = pauseButton
    }
    
    private func addScoreLabel() {
        
        scoreLabel.text = String(score)
        scoreLabel.font = .init(name: "CyberpunkCraftpixPixel", size: UIFont.labelFontSize * 2)
        scoreLabel.textColor = .white
        scoreLabel.isHidden = true

        navigationController?.navigationBar.addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        if let navigationBar = navigationController?.navigationBar {
            
            NSLayoutConstraint.activate([
                scoreLabel.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 18),
                scoreLabel.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor)
            ])
        }
    }
    
    private func presentStartButtonAlert() {

        let startButtonAlert = ActionAlertViewController()
        
        startButtonAlert.addButton(title: "Start", color: .systemGreen) { _ in
            
            self.startGameLoop()
            self.dismiss(animated: true)
        }
        
        present(startButtonAlert, animated: true)
    }
    
    // MARK: Game Logic
    private func startGameLoop() {
        
        scoreLabel.isHidden = false
        navigationItem.rightBarButtonItem?.isHidden = false
        
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
        
        scoreLabel.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        
        let pauseAlert = ActionAlertViewController()
        
        pauseAlert.addTitle(title: nil, titleColor: nil, message: "Score: \(score)")
        
        pauseAlert.addButton(title: "Continue", color: .systemIndigo) { _ in
            
            self.scoreLabel.isHidden = false
            self.navigationItem.rightBarButtonItem?.isHidden = false
            
            self.speed = currentSpeed
            self.dismiss(animated: true)
        }
        
        pauseAlert.addButton(title: "Quit", color: .systemOrange) { _ in
            
            self.enemies.forEach {
                $0.removeFromSuperview()
            }
            self.enemies.removeAll()
            
            self.gameStop()
            self.dismiss(animated: true)
            self.presentStartButtonAlert()
        }
        
        present(pauseAlert, animated: true)
    }
    
    private func gameOver() {
        
        scoreLabel.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        
        displayLink?.invalidate()
        enemySpawnTimer.invalidate()
        
        let restartAlert = ActionAlertViewController()
        
        restartAlert.addTitle(title: "Game Over", titleColor: .systemRed, message: "Score: \(score)")
        
        restartAlert.addButton(title: "Restart", color: .systemIndigo) { _ in
            
            self.gameRestart()
            self.dismiss(animated: true)
        }
        
        restartAlert.addButton(title: "Quit", color: .systemOrange) { _ in
            
            self.enemies.forEach {
                $0.removeFromSuperview()
            }
            self.enemies.removeAll()
            
            self.gameStop()
            self.dismiss(animated: true)
            self.presentStartButtonAlert()
        }
        
        present(restartAlert, animated: true)
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
    
    private func gameStop() {
        
        playerImageView.removeFromSuperview()
        
        enemies.forEach { $0.removeFromSuperview() }
        enemies.removeAll()
        
        speed = 6
        score = 0
        scoreLabel.text = String(score)
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

