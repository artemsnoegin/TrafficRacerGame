//
//  MainViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    
    let car = CarPlayer(color: .systemRed)
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
        let controls = ControlView()
        controls.delegate = car
        view.addSubview(controls)
        createEnemyCar()
    }
    
    private func createEnemyCar() {
        let enemyCar = CarView(color: .systemBlue)
        enemyCar.frame.origin.y = -enemyCar.frame.height
        
        // случайная позиция по оси X
            let minX: CGFloat = 50
            let maxX: CGFloat = self.view.frame.width - 50
            enemyCar.center.x = CGFloat.random(in: minX...maxX)
        
        view.addSubview(enemyCar)

        // скорость падения
        let speed: CGFloat = 3.0

        // таймер для движения
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            // двигаем машинку вниз
            enemyCar.frame.origin.y += speed
            
            // проверяем столкновение
            if enemyCar.frame.intersects(self.car.frame) {
                timer.invalidate()
                self.navigationController?.pushViewController(GameOverViewController(), animated: true)
            }
            
            // если ушла за экран — удалить
            if enemyCar.frame.origin.y > self.view.frame.height {
                timer.invalidate()
                enemyCar.removeFromSuperview()
            }
        }
    }
    
}
