//
//  Contact.swift
//  MessageApp
//
//  Created by Bruno Oliveira Silva on 21/03/22.
//

import Foundation

class Contact: Codable {
    var id: Int
    var name: String
    var photo: String
    var company: Company
}

class Company: Codable {
    var name: String
}
