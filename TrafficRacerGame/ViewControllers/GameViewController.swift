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
    
    private let playerImageView = UIImageView()
    private let enemyImageView = UIImageView()
    
    private var isMovingLeft = false
    private var isMovingRight = false
    
    private let bg1 = UIImageView()
    private let bg2 = UIImageView()
    
    private let speed: CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        
        addControlsOnView()

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
    
    // MARK: Background
    private func setupBackground() {
        guard let roadImage = UIImage(named: "road") else { return }

        bg1.image = roadImage
            bg1.frame = view.bounds
            view.addSubview(bg1)
            
        bg2.image = roadImage
            bg2.frame = view.bounds
            bg2.frame.origin.y = -view.frame.height
            view.addSubview(bg2)
    }
    
    private func moveBackground() {
        bg1.frame.origin.y += speed / 2
        bg2.frame.origin.y += speed / 2
        
        
        if bg1.frame.origin.y >= view.frame.height {
            bg1.frame.origin.y = bg2.frame.origin.y - bg1.frame.height
        }
        
        if bg2.frame.origin.y >= view.frame.height {
            bg2.frame.origin.y = bg1.frame.origin.y - bg2.frame.height
        }
    }
    
    // MARK: Player
    private func addPlayerOnView() {
        guard let name = carNames.randomElement() else { return }
        guard let image = UIImage(named: name) else { return }
        playerImageView.image = image

        let playerSize = image.size
        
        playerImageView.frame.size = playerSize
        
        let playerViewStartPoint = CGPoint(x: view.center.x - playerSize.width / 2,
                                           y: view.frame.height - playerSize.height * 1.5)
        playerImageView.frame.origin = playerViewStartPoint

        playerImageView.transform = CGAffineTransform(rotationAngle: .pi)
        view.addSubview(playerImageView)
    }
    
    private func movePlayer() {
        if isMovingLeft {
            playerImageView.center.x = max(playerImageView.frame.width / 2, playerImageView.center.x - speed)
        }
        if isMovingRight {
            playerImageView.center.x = min(view.frame.width - playerImageView.frame.width / 2, playerImageView.center.x + speed)
        }
    }
    
    // MARK: Player Control Logic
    private func addControlsOnView() {
        let leftTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressLeft(_:)))
        leftTapGesture.minimumPressDuration = 0
        
        let rightTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(pressRight(_:)))
        rightTapGesture.minimumPressDuration = 0
        
        let leftButtonView = UIView()
        leftButtonView.frame.size = CGSize(width: view.frame.width / 2, height: view.frame.height / 2)
        leftButtonView.frame.origin = CGPoint(x: 0, y: view.frame.height / 2)
        leftButtonView.addGestureRecognizer(leftTapGesture)
        view.addSubview(leftButtonView)
        
        let rightButtonView = UIView()
        rightButtonView.frame.size = CGSize(width: view.frame.width / 2, height: view.frame.height / 2)
        rightButtonView.frame.origin = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        rightButtonView.addGestureRecognizer(rightTapGesture)
        view.addSubview(rightButtonView)
    }
    
    @objc func pressLeft(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            isMovingLeft = true
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            isMovingLeft = false
        }
    }

    @objc func pressRight(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {
            isMovingRight = true
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            isMovingRight = false
        }
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
        
        addPlayerOnView()
        
        addEnemyOnView()
    }
    
    @objc func gameLoop() {
        moveBackground()
        
        movePlayer()
        
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
        playerImageView.removeFromSuperview()
        enemyImageView.removeFromSuperview()
        
        isMovingLeft = false
        isMovingRight = false
        
        startGameLoop()
    }
}
