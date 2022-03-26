//
//  FriendContactTableCell.swift
//  WhatsAppMock
//
//  Created by Aloc FL00030 on 26/03/22.
//

import UIKit

class FriendContactTableCell: UITableViewCell {

    static let identifier = "FriendContactTableCell"
    
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
    
    lazy var friendStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Status do Amigo"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(friendImage)
        addSubview(friendName)
        addSubview(friendStatus)
        
        
        NSLayoutConstraint.activate([
            friendImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            friendImage.widthAnchor.constraint(equalToConstant: 40),
            friendImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            friendName.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 8),
            friendName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -8),
            friendName.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            friendStatus.topAnchor.constraint(equalTo: friendName.bottomAnchor, constant: 2),
            friendStatus.leadingAnchor.constraint(equalTo: friendImage.trailingAnchor, constant: 8),
            friendStatus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -8),
            friendStatus.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        self.friendImage.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChatInfo(friendInfo: Profile) {
        friendName.text = friendInfo.name
        
        if let status = friendInfo.status {
            friendStatus.text = status.rawValue
        }
        else {
            friendStatus.isHidden = true
        }
        
        friendImage.loadImage(from: friendInfo.picture)
    }

}
