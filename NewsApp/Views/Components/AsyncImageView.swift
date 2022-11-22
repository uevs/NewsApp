//
//  AsyncImageView.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

struct AsyncImageView<Placeholder: View>: View {
    @EnvironmentObject var data: DataStore
    
    @StateObject private var imageLoader: ImageLoader
    
    let url: URL
    let id: Int
    let placeholder: Placeholder
        
    init(url: URL, id: Int, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.id = id
        self.placeholder = placeholder()
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url, id: id))
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
