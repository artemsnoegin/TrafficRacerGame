//
//  MainViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    
    let car = CarView(color: .systemRed)
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
        let controls = ControlsView()
        controls.delegate = car
        view.addSubview(controls)
    }
    
}
