//
//  ContentView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct ContentView: View {
    var news = [1,2,3,4,5,6,7,8,9]
    var body: some View {
        ScrollView {
            ForEach(news, id: \.self) { _ in
                NewsCard()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
