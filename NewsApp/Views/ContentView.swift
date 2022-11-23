//
//  ContentView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

/// The main view of the app, conists mainly of a custom StickyHeaderScrollView
///
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
                            .scaleEffect(0.9)
                    }
                    .offset(y: animations.isExpanded ? -500 : 0)

                }, contents: {
                    LazyVStack {
                        ForEach(data.news) { article in
                            ExpandableNewsCardView(article: article)
                        }
                    }
                    .padding(.top, 30)
                    .onChange(of: animations.isExpanded, perform: { _ in
                        withAnimation(.linear(duration: 0.2)) {
                            scrollReader.scrollTo(data.currentArticle.id, anchor: .center)
                        }
                    })

                }, maxHeight: 150)
                    .ignoresSafeArea()
            }

            /// The DetailView gets loaded on top of the ScrollView to ensure there are no conflicts with the user interaction since it also contains a ScrollView.
            if animations.showDetail {
                DetailView()
                    .ignoresSafeArea()
            }
        }

    }
}
