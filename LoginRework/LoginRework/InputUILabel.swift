//
//  InputUILabel.swift
//  LoginViewCode
//
//  Created by Aloc FL00030 on 23/03/22.
//

import UIKit

class InputUILabel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var inputStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.alignment = .top
        return stack
    }()
    
    lazy var inputLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var inputTextField: UITextField = {
        let input = UITextField()
        input.backgroundColor = UIColor(white: 0, alpha: 0.1)
        input.font = UIFont.systemFont(ofSize: 14)
        input.layer.cornerRadius = 5
        input.addPaddingLeft(10)
        input.addPaddingRight(10)
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    func setup(title: String, inputPlaceholder: String, secureText: Bool = false) {
        
        inputLabel.text = title
        
        inputTextField.placeholder = inputPlaceholder
        inputTextField.isSecureTextEntry = secureText
        
        addSubview(inputStackView)
        
        inputStackView.addArrangedSubview(inputLabel)
        inputStackView.addArrangedSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            inputStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            inputStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            inputStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            inputLabel.topAnchor.constraint(equalTo: inputStackView.topAnchor, constant: 0),
            inputLabel.leadingAnchor.constraint(equalTo: inputStackView.leadingAnchor, constant:  10),
            inputLabel.trailingAnchor.constraint(equalTo: inputStackView.trailingAnchor, constant:  -10),
            inputLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            /* inputTextField.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 4), */
            inputTextField.leadingAnchor.constraint(equalTo: inputStackView.leadingAnchor, constant:  10),
            inputTextField.trailingAnchor.constraint(equalTo: inputStackView.trailingAnchor, constant: -10),
            inputTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addAction(action: Selector, event: UIControl.Event) {
        inputTextField.addTarget(inputTextField, action: action, for: event)
    }
}
