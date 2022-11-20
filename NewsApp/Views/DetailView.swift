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
            StickyHeaderScrollView(image: {
                Image("placeholder")
                    .resizable()
                    .scaledToFill()
            }, title: {
                ZStack(alignment:.top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.white,.white,.clear], startPoint: .top, endPoint: .bottom))
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
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(article: .constant(News(id: 0, title: "Lorem", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labort laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labort laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labor", release_date: "12/02/12", author: "aaa", image: "")))
    }
}
