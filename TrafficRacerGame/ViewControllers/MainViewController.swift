//
//  MainViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    let car = CarView(color: .systemRed)
    var displayLink: CADisplayLink?
    let backgroundView = BackgroundRoadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addPauseButton()
    }
    
    override func viewDidLayoutSubviews() {
        gameDidLaunch()
    }
    
    private func setupUI() {
        view.addSubview(backgroundView)
        
    }
    
    private func addPauseButton() {
        navigationItem.hidesBackButton = true
        let pauseBarButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"), style: .plain, target: self, action: #selector(didPressPauseButton))
        pauseBarButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = pauseBarButton
    }
    
    @objc private func didPressPauseButton() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    private func gameDidLaunch() {
        view.addSubview(car)
        
        let leftTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(turnLeft(_:)))
        leftTapGesture.minimumPressDuration = 0
        
        let rightTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(turnRight(_:)))
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
    
    @objc private func turnLeft(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            car.direction = .left
            startMoving()
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            car.direction = .none
            stopMoving()
        }
    }
    
    @objc private func turnRight(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            car.direction = .right
            startMoving()
        }
        if gesture.state == .ended || gesture.state == .cancelled {
            car.direction = .none
            stopMoving()
        }
    }
    
    private func startMoving() {
        displayLink = CADisplayLink(target: self, selector: #selector(moveCar))
        displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
    }
    
    private func stopMoving() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func moveCar() {
        if car.frame.origin.x > backgroundView.roadSubview.frame.origin.x {
            if car.direction == .left {
                car.center.x -= 10
            }
        }
        if car.center.x < view.center.x + (backgroundView.roadSubview.frame.width / 2) - car.frame.width / 2 {
            if car.direction == .right {
                car.center.x += 10
            }
        }
    }
    
}
