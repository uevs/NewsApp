//
//  AsyncImageView.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

/// Loads an image from the internet and shows a placeholder while the image is still loading
///
struct AsyncImageView<Placeholder: View>: View {
    @EnvironmentObject var data: DataStore

    @StateObject private var imageLoader: ImageLoader

    private let url: URL
    private let id: Int
    private let placeholder: Placeholder

    init(url: URL, id: Int, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.id = id
        self.placeholder = placeholder()
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url, id: id, networkManager: NetworkManager(), imageStorage: ImagesStorage()))
    }

    var body: some View {
        if imageLoader.image == nil {
            placeholder
        } else {
            Image(uiImage: imageLoader.image!)
                .resizable()
        }
    }
}
