//
//  ImageCache.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

/// Cached images are managed thrugh this singleton containing an NSCache instance.
/// 
class ImageCache {

    static var shared = ImageCache()
    var cache = NSCache<NSURL, UIImage>()

    init() {
        cache.countLimit = 100
    }
}
