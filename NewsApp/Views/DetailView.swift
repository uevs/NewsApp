//
//  DetailView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

/// The view containing the details on the selected article.
/// 
struct DetailView: View {
    @EnvironmentObject var animations: AnimationStates
    @EnvironmentObject var data: DataStore

    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemGroupedBackground)
                .ignoresSafeArea()

            StickyHeaderScrollView(image: {
                AsyncImageView(url: data.currentArticle.imageURL, id: data.currentArticle.id) {
                    ZStack(alignment: .center) {
                        Color(UIColor.systemGroupedBackground)

                        Text("⏳ Loading the image")
                            .font(.title3)
                            .fontWeight(.black)
                            .offset(y: 40)
                    }
                }
                .scaledToFill()
            }, title: {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(UIColor.secondarySystemGroupedBackground), Color(UIColor.secondarySystemGroupedBackground), .clear], startPoint: .top, endPoint: .bottom))

                    VStack(spacing: 4) {
                        Text(data.currentArticle.title)
                            .font(.title.weight(.semibold))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.top, 25)

                        Text(data.currentArticle.formattedDate)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .topTrailing)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 140)
            }, contents: {
                VStack(alignment: .leading) {
                    Text(data.currentArticle.description)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("**Author**: \(data.currentArticle.author)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }, maxHeight: 250)

            Button {
                withAnimation {
                    animations.showDetail = false
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color.primary)
                        .frame(width: 23, height: 23)
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .offset(y: 50)
            .padding()
        }
    }
}
