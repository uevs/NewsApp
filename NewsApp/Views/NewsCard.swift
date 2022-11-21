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
                .foregroundColor(Color("LightDark"))
            
            HStack(alignment: .top) {
                AsyncImageView(url: article.imageURL, id: article.id, placeholder: {
                    Image(systemName: "wifi.exclamationmark")
                        .resizable()
                        .foregroundColor(.red)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                })

                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 50, height: 50)

                
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
