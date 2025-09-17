//
//  GameViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class GameViewController: UIViewController {
    
    let carNames = (0...18).map { "car\($0)" }
    
    let playerImageView = UIImageView()
    let enemyImageView = UIImageView()
    
    var isMovingLeft = false
    var isMovingRight = false
 
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Background
        let bgView = UIImageView(image: UIImage(named: "road"))
        bgView.frame.size = view.frame.size
        view.addSubview(bgView)

        // MARK: Welcome Alert
        let welcomeAlert = UIAlertController(title: "Welcome", message: nil, preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Start", style: .default) { _ in
            self.startGameLoop()
        }
        welcomeAlert.addAction(startAction)
        
        present(welcomeAlert, animated: true)
        
        // MARK: Add Player On View
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
        
        // MARK: Add Controls on View
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
    
    // MARK: Player Movement Logic
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
    
    // MARK: Game Logic
    private func startGameLoop() {
        displayLink = CADisplayLink(target: self, selector: #selector(gameLoop))
        displayLink?.add(to: .main, forMode: .default)
        
        // MARK: Add Enemy On View
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
    
    @objc func gameLoop() {
        
        let speed: CGFloat = 6
        
        if isMovingLeft {
            playerImageView.center.x = max(playerImageView.frame.width / 2, playerImageView.center.x - speed)
        }
        if isMovingRight {
            playerImageView.center.x = min(view.frame.width - playerImageView.frame.width / 2, playerImageView.center.x + speed)
        }

        enemyImageView.frame.origin.y += speed
        
        if enemyImageView.frame.intersects(playerImageView.frame) {
            gameOver()
            return
        }
        
        if enemyImageView.frame.origin.y > view.frame.height {
            guard let enemyCarName = carNames.randomElement() else { return }
            guard let enemyCarImage = UIImage(named: enemyCarName) else { return }
            enemyImageView.image = enemyCarImage
            
            enemyImageView.frame.origin.y = -enemyImageView.frame.height
            
            let minX: CGFloat = 0 + (enemyImageView.frame.width / 2)
            let maxX: CGFloat = view.frame.width - (enemyImageView.frame.width / 2)
            enemyImageView.center.x = CGFloat.random(in: minX...maxX)
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
        playerImageView.center = CGPoint(
            x: view.center.x,
            y: view.frame.height - view.safeAreaInsets.bottom - playerImageView.frame.height / 2
        )
        
        enemyImageView.frame.origin.y = -enemyImageView.frame.height
        
        let minX: CGFloat = 0 + (enemyImageView.frame.width / 2)
        let maxX: CGFloat = view.frame.width - (enemyImageView.frame.width / 2)
        enemyImageView.center.x = CGFloat.random(in: minX...maxX)
        
        isMovingLeft = false
        isMovingRight = false
        
        startGameLoop()
    }
}
