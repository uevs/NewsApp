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
            ScrollView {
                ZStack {
                    VStack(alignment: .leading) {
                        
                        Text(article.description)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(article.author)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    .padding(.top, 200)
                    
                    GeometryReader { reader in
                        VStack(spacing: 0) {
                            Image("placeholder")
                                .resizable()
                                .scaledToFill()
                                .frame(width: reader.size.width, height: self.calculateHederHeight(minHeight: 100, maxHeight: 150, verticalOffset: reader.frame(in: .global).origin.y), alignment: .center)
                                .clipped()
                                .offset(y: reader.frame(in: .global).origin.y < 0 ? abs(reader.frame(in: .global).origin.y) : -reader.frame(in: .global).origin.y)
                            
                            ZStack(alignment:.top) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [.white,.white,.clear], startPoint: .top, endPoint: .bottom))
                                    .frame(height: 90)
                                
                                VStack {
                                    Text(article.title)
                                        .font(.title)
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                        .padding(.top, 5)
                                    
                                    Text(article.formattedDate)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                                }
                                .padding(.horizontal)
                            }
                            .offset(y: reader.frame(in: .global).origin.y < 0 ? abs(reader.frame(in: .global).origin.y) : -reader.frame(in: .global).origin.y)
                            
                            Spacer()
                        }
                        
                    }
                }
            }
            
            Button {
                dismiss.wrappedValue.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
    }
    
    func calculateHederHeight(minHeight: CGFloat, maxHeight: CGFloat, verticalOffset: CGFloat) -> CGFloat {
        /// The verticalOffset is a negative number while scrolling up
        
        if maxHeight + verticalOffset < minHeight {
            /// The user is scrolling up, if it reaches the minHeight it stops
            return minHeight
        } else if maxHeight + verticalOffset > maxHeight {
            /// It dampens the offset the further down the user goes
            return maxHeight + (verticalOffset * 0.5)
        }
        
        /// The user is scrolling down
        return maxHeight + verticalOffset
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(article: .constant(News(id: 0, title: "Lorem", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labort laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labort laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laborLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labor", release_date: "12/02/12", author: "aaa", image: "")))
    }
}
