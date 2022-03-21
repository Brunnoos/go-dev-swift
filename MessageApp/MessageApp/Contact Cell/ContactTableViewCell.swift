//
//  ContactTableViewCell.swift
//  MessageApp
//
//  Created by Bruno Oliveira Silva on 21/03/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    static let identifier = "ContactTableViewCell"
    static let cellHeight = 70
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactCompanyNameLabel: UILabel!
    
    func configure(contact: Contact) {
        
        contactImageView.loadImage(from: contact.photo)
        contactImageView.layer.cornerRadius = 27
        contactImageView.clipsToBounds = true
        
        contactNameLabel.text = contact.name
        contactCompanyNameLabel.text = contact.company.name
    }
    
    
}
