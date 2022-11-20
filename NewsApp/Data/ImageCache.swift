//
//  ImageCache.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

class ImageCache {
    
    static var shared = ImageCache()
    var cache = NSCache<NSURL, UIImage>()
    
    init() {
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
    }
}
