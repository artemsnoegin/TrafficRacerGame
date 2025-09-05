//
//  StartViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 05.09.2025.
//

import UIKit

class StartViewController: UIViewController {
    
    let startButton = CustomButton(title: "Start", color: .systemYellow)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
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
        let buttonAnimation = {
            self.startButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.startButton.alpha = 0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: buttonAnimation) { _ in
            self.startButton.transform = .identity
            self.startButton.alpha = 1
            self.navigationController?.pushViewController(MainViewController(), animated: false)
        }
    }
    
}
