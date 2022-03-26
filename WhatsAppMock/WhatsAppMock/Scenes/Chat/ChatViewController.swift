//
//  ChatViewController.swift
//  WhatsAppMock
//
//  Created by Aloc FL00030 on 25/03/22.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
    }
    
    // MARK: - View Controller Setup
    
    func setupChat(friendName: String) {
        title = friendName
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
