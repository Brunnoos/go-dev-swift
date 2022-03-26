//
//  NewMessageViewController.swift
//  WhatsAppMock
//
//  Created by Aloc FL00030 on 25/03/22.
//

import UIKit

class NewMessageViewController: UIViewController {

    private var safeArea: UILayoutGuide!
    private var allFriends: [Profile]?
    
    // MARK: - Lazy Properties
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Nova Mensagem"
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        
        setupCloseButton()
        setupViewTitle()
        
        setDelegates()
        registerTableCell()
        setupTableOnView()
    }
    
    // MARK: - View Controller Setup
    
    func onCallView(allFriends: [Profile]) {
        self.allFriends = allFriends
    }
    
    private func setupView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
    }
    
    private func setupViewTitle() {
        view.addSubview(viewTitle)
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            viewTitle.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor, constant: 0),
            viewTitle.heightAnchor.constraint(equalToConstant: 20),
            viewTitle.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    // MARK: - View Close Button Functions
    
    private func setupCloseButton() {
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
    }
    
    @objc private func closeButtonAction() {
        dismiss(animated:true)
    }

    // MARK: - Table View Setup
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableCell() {
        tableView.register(FriendContactTableCell.self, forCellReuseIdentifier: FriendContactTableCell.identifier)
    }
    
    private func setupTableOnView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 36),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

}

extension NewMessageViewController: UITableViewDelegate {
    
}

extension NewMessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendContactTableCell.identifier, for: indexPath) as? FriendContactTableCell else { return UITableViewCell() }
        
        if let friends = allFriends {
            cell.setupChatInfo(friendInfo: friends[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let friends = allFriends {
            return friends.count
        }
        else {
            return 0
        }
    }
}
