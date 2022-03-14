//
//  ViewController.swift
//  Aula 05
//
//  Created by Aloc FL00030 (Bruno Oliveira) on 11/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setDelegates()
    }
    
    private func setDelegates(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        print("O texto no campo de e-mail é \(emailTextField.text ?? "inválido")")
        
        print("O texto do campo de senha é: \(passwordTextField.text ?? "inválido")")
        
        OnLoginAttempted(email: emailTextField.text, password: passwordTextField.text)
    }
    
    
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


extension ViewController {
    
    // MARK: - Login Functions
    
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

