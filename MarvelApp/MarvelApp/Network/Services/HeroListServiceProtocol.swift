//
//  HeroListServiceProtocol.swift
//  MarvelApp
//
//  Created by Aloc FL00030 on 01/04/22.
//

import Foundation

enum HeroError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol HeroListServiceProtocol: AnyObject {
    
    func execute(handler: @escaping(Result<HeroesResponse, HeroError>) -> Void)
    
}
