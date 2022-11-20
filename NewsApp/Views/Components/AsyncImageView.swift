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
    let placeholder: Placeholder
        
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.url = url
        self.placeholder = placeholder()
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        
        if imageLoader.image == nil {
            placeholder
        } else {
            Image(uiImage: imageLoader.image!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 50, height: 50)
        }
    }
}

//struct NetworkImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        AsyncImageView()
//    }
//}
