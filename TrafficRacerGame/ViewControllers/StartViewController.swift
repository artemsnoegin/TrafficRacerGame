//
//  StartViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let startButton = CustomButton(title: "Start", color: .systemYellow)
        startButton.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.heightAnchor.constraint(equalToConstant: startButton.height),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    @objc private func startGame(_ sender: UIButton) {
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
}
