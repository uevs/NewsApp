//
//  NetworkLayer.swift
//  NewsApp
//
//  Created by leonardo on 15/12/22.
//

import Foundation
import Combine

protocol NetworkLayer {
    func getData(url: URL) -> AnyPublisher<Data, Error>
}
