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
    
    private(set) var isLoading = false

    private let url: URL
    private var cache: NSCache<NSURL, UIImage>
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing") // check

    init(url: URL, cache: NSCache<NSURL, UIImage>) {
        self.url = url
        self.cache = cache
        load()
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        
        if let cachedImage: UIImage = cache.object(forKey: url as NSURL) {
            self.image = cachedImage
        }
        
        cancellable = NetworkManager.getData(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                //
            }, receiveValue: { [weak self] (image) in
                self?.image = image
//                self?.cache.setObject(image, forKey: self?.url as NSURL)
            })
        
    }
    
//    private func cache(_ image: UIImage?) {
//        image.map {self.cache[url] = $0}
//    }
    
 
}
