//
//  ContentView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: DataStore
    
    var body: some View {
        
        StickyHeaderScrollView(image: {
            Image("placeholder")
                .resizable()
                .scaledToFill()
        }, contents: {
            LazyVStack {
                ForEach(data.news) { article in
                    NewsCard(article: article, imageLoader: ImageLoader(url: article.imageURL, cache: data.imageCache))
                }
            }
        }, maxHeight: 150)
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
