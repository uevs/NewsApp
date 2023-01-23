//
//  ImageLoader.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import Foundation
import Combine
import SwiftUI

/// Responsible for loading a specific image.
/// It first checks if the image is on the cache, then if it's on local storage and only then it loads it from the internet.
/// 
class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    private let url: URL
    private let id: Int
    private var cancellable: AnyCancellable?
    
    private var networkManager: any NetworkLayer
    private var imageStorage: any PersistenceHandler

    init(url: URL, id: Int, networkManager: some NetworkLayer, imageStorage: some PersistenceHandler) {
        self.url = url
        self.id = id
        self.networkManager = networkManager
        self.imageStorage = imageStorage
        load()
    }

    deinit {
        cancellable?.cancel()
    }

    private func load() {

        /// Checks if the image already exists in the cache, if so it loads it.
        if let cachedImage = ImageCache.shared.cache.object(forKey: self.url as NSURL) {
            self.image = cachedImage
            return
        }

        /// Checks if the image already exists in the local storage, if so it loads it and caches it.
        if let storedImage = imageStorage.getImage(imageName: String(id), folder: "images") {
            self.image = storedImage
            cacheImage(storedImage)
            return
        }

        /// Gets the image from the internet.
        cancellable = networkManager.getData(url: url)
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
                self?.saveImage(image)
                self?.cacheImage(image)
                self?.image = image
            })
    }

    /// Saves the image to local storage.
    private func saveImage(_ image: UIImage?) {
        if image != nil {
            imageStorage.saveImage(image: image!, imageName: String(id), folder: "images")
            print("saving image stored image")
        }
    }

    /// Savesthe image in the cache.
    private func cacheImage(_ image: UIImage?) {
        if image != nil {
            ImageCache.shared.cache.setObject(image!, forKey: self.url as NSURL)
        }
    }
}
