//
//  ContentView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var data: DataStore
    @EnvironmentObject var animations: AnimationManager
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
                    .opacity(animations.isExpanded ? 0 : 1)
                }, contents: {
                    VStack {
                        ForEach(data.news) { article in
                            NewsCardView(article: article)
                        }
                    }
                    .onChange(of: animations.isExpanded, perform: { newValue in
                        withAnimation {
                            scrollReader.scrollTo(animations.id, anchor: .center)
                        }
                    })
                }, maxHeight: 170)
            }
        }
        
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
