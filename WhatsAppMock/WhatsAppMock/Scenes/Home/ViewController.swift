//
//  ViewController.swift
//  WhatsAppMock
//
//  Created by Aloc FL00030 on 25/03/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Private Properties
    
    private var safeArea: UILayoutGuide!
    
    var profile: Profile?
    var allFriends: [Profile]?
    
    // MARK: - Lazy Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    // MARK: - View Controller Setup
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Adding Title Bar Buttons
        setupEditButton()
        setupNewMessageButton()
        
        // Deselect row when Home is being loaded from ChatView
        if let lastRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: lastRow, animated: false)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSafeArea()
        setupViewVisual()
        
        getProfileData()
        
        setDelegates()
        registerTableCell()
        setupTableOnView()
    }
    
    private func setupSafeArea() {
        safeArea = view.layoutMarginsGuide
    }
    
    private func setupViewVisual() {
        view.backgroundColor = .white
        title = "Chats"
    }
    
    private func setupEditButton() {
        let newEditButton =  UIBarButtonItem(title: "Edit", style: .plain, target: self, action: nil)
        
        navigationItem.leftBarButtonItems = [newEditButton]
    }
    
    private func setupNewMessageButton() {
        let newMessageButton = UIBarButtonItem(image: UIImage.init(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(showNewMessageView))
        
        navigationItem.rightBarButtonItems = [newMessageButton]
    }
    
    @objc func showNewMessageView() {
        let newMessageView = NewMessageViewController()
        
        if let allFriends = allFriends {
            newMessageView.onCallView(allFriends: allFriends)
        }
        
        navigationController?.present(newMessageView, animated: true, completion: nil)
    }

    // MARK: - Table View Setup
    
    private func getProfileData() {
        Service.shared.getProfile { result in
            switch result {
            case .success(let welcome):
                self.profile = welcome.profile
                self.allFriends = welcome.allFriends
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableCell() {
        tableView.register(ChatLogTableCell.self, forCellReuseIdentifier: ChatLogTableCell.identifier)
    }
    
    private func setupTableOnView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatViewController = ChatViewController()
        
        if let _ = navigationController, let profile = self.profile, let friends = profile.friends {
            chatViewController.setupChat(friendName: friends[indexPath.row].name)
            navigationController?.pushViewController(chatViewController, animated: true)
        }
        else {
            present(chatViewController, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let profile = self.profile, let friends = profile.friends {
            return friends.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatLogTableCell.identifier, for: indexPath) as? ChatLogTableCell else { return UITableViewCell()}
        
        if let profile = self.profile, let friends = profile.friends {
            cell.setupChatInfo(friendInfo: friends[indexPath.row])
        }
        
        return cell
    }
    
    
}
