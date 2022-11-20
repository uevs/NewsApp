//
//  ImageLoader.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage? = nil
    
//    private(set) var isLoading = false
    
    private let url: URL
    private var cancellable: AnyCancellable?
    
//    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL) {
        self.url = url
        load()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        
        if let cachedImage = ImageCache.shared.cache.object(forKey: self.url as NSURL) {
            print("found cached image")
            self.image = cachedImage
            return
        }
        
        cancellable = NetworkManager.getData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] (image) in
                self?.cacheImage(image)
                self?.image = image
            })
        
    }
    
    private func cacheImage(_ image: UIImage?) {
        if image != nil {
            ImageCache.shared.cache.setObject(image!, forKey: self.url as NSURL)
        }
    }
    
 
}
