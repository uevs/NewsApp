//
//  NetworkManager.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation
import Combine


class NetworkManager {
    
    private enum DataError: Error {
        case cantDecode;
        case badResponse(response: URLResponse, url: URL)
    }
    
    static func getData(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                try checkResponse(dataTaskOutput: $0, url: url)
            }
            .retry(3)
            .eraseToAnyPublisher()
    }
    

    private static func checkResponse(dataTaskOutput: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = dataTaskOutput.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw DataError.badResponse(response: dataTaskOutput.response, url: url)
        }
        
        return dataTaskOutput.data
        }
}
