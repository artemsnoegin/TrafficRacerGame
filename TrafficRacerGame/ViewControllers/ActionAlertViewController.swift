//
//  ActionAlertViewController.swift
//  TrafficRacerGame
//
//  Created by Артём Сноегин on 11.10.2025.
//

import UIKit

class ActionAlertViewController: UIViewController {
    
    private let contentStack = UIStackView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        view.backgroundColor = .black.withAlphaComponent(0.2)
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        
        contentStack.axis = .vertical
        contentStack.spacing = 5
        
        view.addSubview(contentStack)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func addButton(title: String, color: UIColor, action: @escaping (UIAction) -> ()) {
        
        let actionButton = UIButton()
        actionButton.setTitle(title, for: .normal)
        actionButton.titleLabel?.font = .init(name: "CyberpunkCraftpixPixel", size: UIFont.labelFontSize * 3)
        actionButton.setTitleColor(color, for: .normal)
        actionButton.setTitleColor(.systemYellow, for: .highlighted)
        
        actionButton.titleLabel?.addTextShadow()
        
        actionButton.addAction(UIAction(handler: action), for: .touchUpInside)
        
        
        contentStack.addArrangedSubview(actionButton)
    }
    
    func addTitle(title: String?, titleColor: UIColor?, message: String? = nil) {

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .init(name: "CyberpunkCraftpixPixel", size: UIFont.labelFontSize * 3)
        titleLabel.textColor = titleColor
        titleLabel.textAlignment = .center
        
        contentStack.addArrangedSubview(titleLabel)
        
        titleLabel.addTextShadow()
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = .init(name: "CyberpunkCraftpixPixel", size: UIFont.labelFontSize * 2)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        
        contentStack.addArrangedSubview(messageLabel)
        
        let spacing = UIView()
        spacing.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        contentStack.addArrangedSubview(spacing)
    }
}

extension UILabel {
    
    func addTextShadow() {
        
        guard let superview = superview else { return }
        
        let shadowLabel = UILabel()
        
        shadowLabel.text = text
        shadowLabel.font = font
        shadowLabel.textColor = .black
        
        superview.insertSubview(shadowLabel, belowSubview: self)
        
        shadowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 2),
            shadowLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 4),
        ])
    }
}
