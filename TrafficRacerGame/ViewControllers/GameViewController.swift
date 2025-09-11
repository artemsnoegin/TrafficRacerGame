//
//  GameViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class GameViewController: UIViewController {
    
    let playerView = UIView()
    let enemyView = UIView()
    
    var isMovingLeft = false
    var isMovingRight = false
 
    var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Background
        view.backgroundColor = .gray

        // MARK: Welcome Alert
        let welcomeAlert = UIAlertController(title: "Welcome", message: nil, preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Start", style: .default) { _ in
            self.startGameLoop()
        }
        welcomeAlert.addAction(startAction)
        
        present(welcomeAlert, animated: true)
        
        // MARK: Add Player On View
        playerView.backgroundColor = .red
        
        let playerViewSize = CGSize(width: 60, height: 60)
        playerView.frame.size = playerViewSize
        
        let playerViewStartPoint = CGPoint(x: view.center.x - playerViewSize.width / 2,
                                           y: view.frame.height - (playerViewSize.height * 2))
        playerView.frame.origin = playerViewStartPoint
        
        view.addSubview(playerView)
        
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
        enemyView.backgroundColor = .blue
        
        let enemyViewSize = CGSize(width: 60, height: 60)
        enemyView.frame.size = enemyViewSize
        
        enemyView.frame.origin.y = -enemyViewSize.height
        
        let minX: CGFloat = 0
        let maxX: CGFloat = view.frame.width - enemyViewSize.width
        enemyView.center.x = CGFloat.random(in: minX...maxX)
        
        view.addSubview(enemyView)
    }
    
    @objc func gameLoop() {
        
        let speed: CGFloat = 6
        
        if isMovingLeft {
            playerView.center.x = max(playerView.frame.width / 2, playerView.center.x - speed)
        }
        if isMovingRight {
            playerView.center.x = min(view.frame.width - playerView.frame.width / 2, playerView.center.x + speed)
        }

        enemyView.frame.origin.y += speed
        
        if enemyView.frame.intersects(playerView.frame) {
            gameOver()
            return
        }
        
        if enemyView.frame.origin.y > view.frame.height {
            enemyView.frame.origin.y = -enemyView.frame.height
            
            let minX: CGFloat = 0 + (enemyView.frame.width / 2)
            let maxX: CGFloat = view.frame.width - (enemyView.frame.width / 2)
            enemyView.center.x = CGFloat.random(in: minX...maxX)
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
        playerView.center = CGPoint(
            x: view.center.x,
            y: view.frame.height - view.safeAreaInsets.bottom - playerView.frame.height / 2
        )
        
        enemyView.frame.origin.y = -enemyView.frame.height
        
        let minX: CGFloat = 0 + (enemyView.frame.width / 2)
        let maxX: CGFloat = view.frame.width - (enemyView.frame.width / 2)
        enemyView.center.x = CGFloat.random(in: minX...maxX)
        
        isMovingLeft = false
        isMovingRight = false
        
        startGameLoop()
    }
}
