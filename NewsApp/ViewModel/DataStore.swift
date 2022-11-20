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
    
    private var userDefaults = UserDefaults.standard
    
    private var cancellables = Set<AnyCancellable>()
    
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
        if userDefaults.object(forKey: "news") != nil {
            news = getStoredNews(userDefaults.object(forKey: "news") as! Data)
        }
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
                if self?.news != articles {
                    self?.storeNews(articles)
                }
                self?.news = articles
            }
            .store(in: &cancellables)
    }
    
    func getStoredNews(_ data: Data) -> [News] {
        guard let decodedNews = try? JSONDecoder().decode([News].self, from: data) else {return []}
        return decodedNews
    }
    
    func storeNews(_ news: [News]) {
        guard let encodedNews = try? JSONEncoder().encode(news) else {return}
        self.userDefaults.set(encodedNews, forKey: "news")
    }
}
