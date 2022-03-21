//
//  Service.swift
//  MessageApp
//
//  Created by Aloc FL00030 on 21/03/22.
//

import Foundation

enum ContactError: Error {
    case invalidURL
    case noData
    case invalidData
}

protocol ServiceProtocol {
    func getContacts(completion: @escaping(Result<[Contact], ContactError>) -> Void)
}

class Service: ServiceProtocol {
    
    let session = URLSession.shared
    let url = "https://run.mocky.io/v3/f0c36709-84e2-4043-a0f0-3bec512f6c84"
    
    static var shared: Service = {
        let instance = Service()
        return instance
    }()
    
    func getContacts(completion: @escaping (Result<[Contact], ContactError>) -> Void) {
        guard let url = URL(string: url) else { return completion(.failure(.invalidURL))}
        
        let dataTask = session.dataTask(with: url) { data, _, _ in
            
            do {
                guard let jsonData = data else { return completion(.failure(.noData)) }
                
                let decoder = JSONDecoder()
                
                let urlResponse = try decoder.decode([Contact].self, from: jsonData)
                
                completion(.success(urlResponse))
            }
            catch {
                completion(.failure(.invalidData))
            }
        }
        
        dataTask.resume()
    }
}
