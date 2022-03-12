//
//  ViewController.swift
//  Aula 05
//
//  Created by Aloc FL00030 on 11/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        print("O texto no campo de e-mail é \(emailTextField.text ?? "vazio")")
        
        let alert = UIAlertController(title: "Login", message: "Message", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { confirm in print("Você confirmou.")}))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { cancel in print("Você cancelou.")}))
        
        alert.addAction(UIAlertAction(title: "Destruir", style: .destructive, handler: {destruct in print("Você destruiu") } ))
        
        present(alert, animated: true, completion: nil)
    }
    
}

