//
//  MainViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addPauseButton()
    }
    
    private func setupUI() {
        let bgView = BackgroundRoadView()
        view.addSubview(bgView)
        
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
    
}
