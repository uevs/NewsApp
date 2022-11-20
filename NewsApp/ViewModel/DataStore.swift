//
//  DataStore.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation
import SwiftUI
import Combine

class DataStore: ObservableObject {
    
    @Published private(set) var news: [News] = []
    @Published private(set) var imageCache = NSCache<NSURL, UIImage>()
    
    var cancellables = Set<AnyCancellable>()
    
    private let apiDomain: String = "run.mocky.io"
    private let apiEndPoint: String = "/v3/de42e6d9-2d03-40e2-a426-8953c7c94fb8"
    
    lazy private var newsUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiDomain
        components.path = apiEndPoint
        return components
    }()
    
    lazy private var newsUrl: URL = {
        guard let unwrappedUrl = newsUrlComponents.url else { fatalError("Wrong URL") }
        return unwrappedUrl
    }()
 
    init() {
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 1024 * 1024 * 100
        getNews()
    }
    
    func getNews() {
        NetworkManager.getData(url: newsUrl)
            .decode(type: [News].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (articles) in
                self?.news = articles
            }
            .store(in: &cancellables)
    }
}
