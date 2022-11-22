//
//  ContentView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: DataStore
    @EnvironmentObject var animations: AnimationStates
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollViewReader { scrollReader in
                    StickyHeaderScrollView(image: {
                    ZStack {
                        Color(UIColor.secondarySystemGroupedBackground)
                        Image(colorScheme == .dark ? "header_d" : "header_l")
                            .resizable()
                            .scaledToFill()
                    }
                    .offset(y: animations.isExpanded ? -500 : 0)
                        
                }, contents: {
                    LazyVStack {
                        ForEach(data.news) { article in
                            ExpandableNewsCardView(article: article)
                        }
                    }
                    .padding(.top, 30)
                    .onChange(of: animations.isExpanded, perform: { newValue in
                        withAnimation {
                            scrollReader.scrollTo(data.currentArticle.id, anchor: .center)
                        }
                    })
                    
                }, maxHeight: 170)
                    .ignoresSafeArea()
            }
            
            if animations.showDetail {
                DetailView()
                    .ignoresSafeArea()
            }
        }
        
    }
}
