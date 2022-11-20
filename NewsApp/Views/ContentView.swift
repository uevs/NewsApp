//
//  ContentView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: DataStore
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black
            } else {
                Color(UIColor.systemGray6)
            }
            
            StickyHeaderScrollView(image: {
                Image(colorScheme == .dark ? "header_d" : "header_l")
                    .resizable()
                    .scaledToFill()
            }, contents: {
                LazyVStack {
                    ForEach(data.news) { article in
                        NewsCard(article: article)
                    }
                }
            }, maxHeight: 170)
        }

    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
