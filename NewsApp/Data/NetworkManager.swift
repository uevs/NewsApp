//
//  NetworkManager.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation
import Combine

/// Manages network calls with combine.
/// It's responsible for getting any kind of data from an URL.
///
class NetworkManager {

    private enum DataError: Error {
        case cantDecode
        case badResponse(response: URLResponse, url: URL)
    }

    /// Gets data from an URL, retries three times in case of network errors.
    static func getData(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                try checkResponse(dataTaskOutput: $0, url: url)
            }
            .retry(3)
            .eraseToAnyPublisher()
    }

    ////  Returns the data from the network call if there are no errors in the response.
    private static func checkResponse(dataTaskOutput: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {

        guard let response = dataTaskOutput.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw DataError.badResponse(response: dataTaskOutput.response, url: url)
        }

        return dataTaskOutput.data
        }
}
