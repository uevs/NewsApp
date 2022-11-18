//
//  NetworkManager.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation
import UIKit


class NetworkManager {
        
    static var shared: NetworkManager = NetworkManager()
    

    private let userDefaults: UserDefaults = UserDefaults.standard
    private let decoder: JSONDecoder = JSONDecoder()
    
    private enum DataError: Error {
        case cantDecode;
        case badResponse(response: URLResponse)
    }
    
    @MainActor
    func setup() {
        
    }
    
    func getData(url: URL) async throws -> [News] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DataError.badResponse(response: response)
        }
        
        guard let result = try? decoder.decode([News].self, from: data) else {
            throw DataError.cantDecode
        }
        
        return result
    }
    
    func getImage(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DataError.badResponse(response: response)
        }
        
        return UIImage(data: data)!
    }
    
    func updateStoredData() {
        
    }
    
    func loadImage() {
        
    }
    
    
}
