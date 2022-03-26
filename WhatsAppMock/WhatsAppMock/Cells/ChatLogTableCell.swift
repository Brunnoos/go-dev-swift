//
//  ChatLogTableCell.swift
//  WhatsAppMock
//
//  Created by Aloc FL00030 on 25/03/22.
//

import UIKit

class ChatLogTableCell: UITableViewCell {

    static let identifier = "ChatlogTableCell"
    
    lazy var friendImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.clipsToBounds = true
        return image
    }()
    
    lazy var friendName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Nome do Amigo"
        label.textColor = .black
        return label
    }()
    
    lazy var friendMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Mensagem do Amigo"
        return label
    }()
    
    lazy var friendMessageDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "11/04/2021"
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(friendImage)
        addSubview(friendName)
        addSubview(friendMessage)
        addSubview(friendMessageDate)
        
        
        NSLayoutConstraint.activate([
            friendImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            friendImage.widthAnchor.constraint(equalToConstant: 40),
            friendImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            friendMessageDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            friendMessageDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -8),
            friendMessageDate.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            friendName.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 8),
            friendName.trailingAnchor.constraint(equalTo: friendMessageDate.leadingAnchor, constant:  -8),
            friendName.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            friendMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor, constant: 2),
            friendMessage.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 8),
            friendMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -8),
            friendMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        
        
        self.friendImage.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChatInfo(friendInfo: Friend) {
        friendName.text = friendInfo.name
        friendMessage.text = friendInfo.lastChat
        friendMessageDate.text = friendInfo.latestTimestamp
        
        friendImage.loadImage(from: friendInfo.picture)
    }
}
