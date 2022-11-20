//
//  NewsCard.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct NewsCard: View {
    
    @EnvironmentObject var data: DataStore
    @Environment(\.colorScheme) var colorScheme

    
    @State var article: News
    @State var showDetail: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(colorScheme == .dark ? Color(UIColor(red: 0.09, green: 0.09, blue: 0.09, alpha: 1.00)) : Color.white)
            
            HStack(alignment: .top) {
                AsyncImageView(url: article.imageURL, id: article.id, placeholder: {
                    Image(systemName: "square")
                })

                
                VStack(alignment: .leading) {
                    Text(article.title)
                        .bold()
                    
                    Text(article.description)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                Spacer()
            }
            .padding()
        }
        .padding([.top,.horizontal])
        .frame(maxWidth: .infinity, maxHeight: 150)
        .onTapGesture {
            showDetail.toggle()
        }
        .fullScreenCover(isPresented: $showDetail) {
            DetailView(article: $article)
        }
    }
}

//struct NewsCard_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsCard()
//    }
//}
