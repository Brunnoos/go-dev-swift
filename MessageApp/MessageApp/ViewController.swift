//
//  ViewController.swift
//  MessageApp
//
//  Created by Bruno Oliveira Silva on 21/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    lazy var contacts = [Contact]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        delegates()
        registerNib()
        getData()
        showLoadingIcon()
    }
    
    // MARK: - Load Data Functions
    
    private func getData() {
        Service.shared.getContacts { result in
            switch result {
            case .success(let response):
                self.contacts = response
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                }
            case .failure(let error):
                print(error)
            }
            
            self.hideLoadingIcon()
        }
    }

    // MARK: - Table View Setup Functions
    
    private func delegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isHidden = true
    }
    
    private func registerNib() {
        let nib = UINib(nibName: ContactTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ContactTableViewCell.identifier)
    }
    
    // MARK: - Activity Icon Functions
    
    private func showLoadingIcon() {
        loadingIcon.startAnimating()
        loadingIcon.isHidden = false
    }
    
    private func hideLoadingIcon() {
        DispatchQueue.main.async {
            self.loadingIcon.stopAnimating()
            self.loadingIcon.isHidden = true
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        cell.configure(contact: contacts[indexPath.row])
        
        return cell
    }
    
    // Defines Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ContactTableViewCell.cellHeight)
    }
    
}

