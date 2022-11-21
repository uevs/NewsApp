//
//  DetailView.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var dismiss
    
    @Binding var article: News
    
    var body: some View {
        ZStack {
            Color("LightDark")
                .ignoresSafeArea()
            StickyHeaderScrollView(image: {
                AsyncImageView(url: article.imageURL, id: article.id) {
                    ZStack(alignment: .center) {
                        Color("LightDarkBG")
                        
                        Text("⏳ Loading the image")
                            .font(.title3)
                            .fontWeight(.black)
                            .offset(y: 40)
                    }
                }
                .scaledToFill()
            }, title: {
                ZStack(alignment:.top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color("LightDark"), Color("LightDark"),.clear], startPoint: .top, endPoint: .bottom))
                        .frame(height: 90)
                    
                    VStack {
                        Text(article.title)
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.top, 5)
                        
                        Text(article.formattedDate)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .topTrailing)
                    }
                    .padding(.horizontal)
                }
            }, contents: {
                VStack(alignment: .leading) {
                    Text(article.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(article.author)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                .padding(.horizontal)
            }, maxHeight: 250)
            
            Button {
                dismiss.wrappedValue.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("LightDark"))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(article: )
//    }
//}
