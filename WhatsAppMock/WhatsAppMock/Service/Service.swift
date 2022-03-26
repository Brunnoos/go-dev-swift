//
//  Service.swift
//  WhatsAppMock
//
//  Created by Aloc FL00030 on 25/03/22.
//

import Foundation

enum FriendRequestError: Error {
    case URLError
    case NoDataError
    case DecoderError
}

protocol ServiceProtocol {
    func getProfile(completion: @escaping(Result<Welcome, FriendRequestError>) -> Void)
}

class Service: ServiceProtocol {
    
    let session = URLSession.shared
    let url = "https://run.mocky.io/v3/229fc3ea-ad0a-454c-a91a-0cc226b919d8"
    
    static let shared: Service = {
        let instance = Service()
        return instance
    }()
    
    func getProfile(completion: @escaping (Result<Welcome, FriendRequestError>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(.URLError))}
        
        let dataTask = session.dataTask(with: url) { data, _, _ in
            
            do {
                
                guard let jsonData = data else { return completion(.failure(.NoDataError))}
                
                let decoder = JSONDecoder()
                
                let userResponse = try decoder.decode(Welcome.self, from: jsonData)
                
                completion(.success(userResponse))
            } catch {
                completion(.failure(.DecoderError))
            }
        }
        
        dataTask.resume()
    }
}
