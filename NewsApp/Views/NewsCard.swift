//
//  NewsCard.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct NewsCard: View {
    
    @EnvironmentObject var data: DataStore
    
    @State var article: News
    @State var showDetail: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.red)
            
            HStack(alignment: .top) {
                AsyncImageView(url: article.imageURL, placeholder: {
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
        .shadow(color: .gray.opacity(0.5), radius: 20)
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
