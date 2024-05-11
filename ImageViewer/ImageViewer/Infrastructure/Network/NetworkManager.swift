//
//  NetworkManager.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(from urlString: String) async throws -> T {
        
        let data = try await request(from: urlString)
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodeFailed
        }
        return decodedResponse
    }
    
    func request(from urlString:String) async throws -> Data {
        guard let url = URL(string: urlString) else  {
            throw NetworkError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
