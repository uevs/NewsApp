//
//  DataStore.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation
import SwiftUI
import Combine

/// Gets and stores News data from the API.
///
class DataStore: ObservableObject {

    /// News data from the API is stored in this array at runtime.
    @Published private(set) var news: [News] = []

    /// The article that the users has selected to be displayed in full detail.
    @Published var currentArticle: News = News(id: 0, title: "", description: "", release_date: "", author: "", image: "")
    
    private var networkManager: any NetworkLayer

    /// The News data is also stored on UserDefaults.
    private var userDefaults = UserDefaults.standard

    private var cancellables = Set<AnyCancellable>()

    private let apiDomain: String = "run.mocky.io"
    private let apiEndPoint: String = "/v3/b3f31426-ce87-4353-8227-7edcf27c32f3"

    /// Returns the assembled URLComponents of the API endpoint.
    lazy private var newsUrlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = apiDomain
        components.path = apiEndPoint
        return components
    }()

    /// Unwraps the URL, there's no fallback since the URL is hardcoded.
    lazy private var newsUrl: URL = {
        guard let unwrappedUrl = newsUrlComponents.url else { fatalError("Wrong URL") }
        return unwrappedUrl
    }()

    init(_ networkManager: some NetworkLayer) {
        self.networkManager = networkManager
        ///  Loads the news from UserDefaults, if any, to ensure that the app always shows the latest fetched information when loaded.
        ///  Loads the news from UserDefaults, if any, to ensure that the app always shows the latest fetched information when loaded.
        if userDefaults.object(forKey: "news") != nil {
            news = getStoredNews(userDefaults.object(forKey: "news") as! Data)
        }

        /// Loads/updates the news from the internet.
        getNews()
    }

    /// Gets News data from the internet and decodes it. Then it sorts it by date and stores it on memory and on UserDefaults.
    private func getNews() {
        networkManager.getData(url: newsUrl)
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
                let sortedArticles = articles.sorted { first, second in
                    first.date > second.date
                }

                if self?.news != sortedArticles {
                    self?.storeNews(sortedArticles)
                }
                self?.news = sortedArticles
            }
            .store(in: &cancellables)
    }

    /// Returns News data from the UserDefaults.
    private func getStoredNews(_ data: Data) -> [News] {
        guard let decodedNews = try? JSONDecoder().decode([News].self, from: data) else {return []}
        return decodedNews
    }

    /// Saves News data to the UserDefaults.
    private func storeNews(_ news: [News]) {
        guard let encodedNews = try? JSONEncoder().encode(news) else {return}
        self.userDefaults.set(encodedNews, forKey: "news")
    }
}
