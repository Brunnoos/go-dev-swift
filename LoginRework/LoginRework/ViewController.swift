//
//  ViewController.swift
//  LoginRework
//
//  Created by Aloc FL00030 on 24/03/22.
//

import UIKit

class ViewController: UIViewController {

    private var safeArea: UILayoutGuide!
    
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    lazy var emailInput: InputUILabel = {
        let label = InputUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setup(title: "E-mail", inputPlaceholder: "Digite seu e-mail...")
        return label
    }()
    
    lazy var passwordInput: InputUILabel = {
        let label = InputUILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setup(title: "Senha", inputPlaceholder: "Digite sua senha...", secureText: true)
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        emailInput.inputTextField.delegate = self
        passwordInput.inputTextField.delegate = self
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(emailInput)
        mainStackView.addArrangedSubview(passwordInput)
        mainStackView.addArrangedSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(onLoginPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            mainStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            emailInput.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 0),
            emailInput.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0),
            emailInput.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 0),
            //emailInput.heightAnchor.constraint(equalToConstant: 74)
        ])
        
        NSLayoutConstraint.activate([
            //passwordInput.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10),
            passwordInput.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 0),
            passwordInput.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 0),
            //passwordInput.heightAnchor.constraint(equalToConstant: 74)
        ])
        
        NSLayoutConstraint.activate([
            //loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func onLoginPressed() {
        OnLoginAttempted(email: emailInput.inputTextField.text, password: passwordInput.inputTextField.text)
    }
    
    func OnLoginAttempted(email:String?, password:String?) {
        
        var emailVerified : Bool
        var passwordVerified : Bool
        
        if let emailText = email {
            emailVerified = fieldCheckup(input: emailText, regex: "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]+$")
        }
        else {
            emailVerified = false
        }
        
        if let passwordText = password {
            passwordVerified = fieldCheckup(input: passwordText, regex: "[\\w]{8,32}")
        }
        else {
            passwordVerified = false
        }
        
        print("Email está válido? \(emailVerified)")
        print("Senha está válida? \(passwordVerified)")
        
        presentLoginAlert(emailSuccessful: emailVerified, passwordSuccessful: passwordVerified)
        
    }
    
    func fieldCheckup(input: String?, regex: String) -> Bool {
        
        if let inputText = input {
            let regexTest = matchesForRegexInText(regex: regex, text: inputText)
            
            return regexTest.count == 1
        }
        else {
            return false
        }
        
    }
    
    func matchesForRegexInText(regex: String, text: String) -> [String] {

        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text,
                                                options: [], range: NSMakeRange(0, nsString.length))
            
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func presentLoginAlert(emailSuccessful: Bool, passwordSuccessful: Bool) {
        
        let titleString : String
        let messageString: String
        
        if !emailSuccessful && !passwordSuccessful {
            titleString = "Login Inválido"
            messageString = "Os campos de e-mail e senha estão inválidos."
        }
        else if emailSuccessful && passwordSuccessful {
            titleString = "Login Realizado"
            messageString = "O Login foi realizado com sucesso!"
        }
        else if !emailSuccessful {
            titleString = "Login Inválido"
            messageString = "O campo de e-mail não corresponde ao formato de e-mail."
        }
        else {
            titleString = "Login Inválido"
            messageString = "O campo de senha precisa ter 8 caracteres ou mais"
        }
        
        let alert = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
}

