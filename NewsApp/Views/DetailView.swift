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
            VStack(alignment: .leading) {
                Image(systemName: "square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height/4)
                    .padding(.bottom)
                
                Group {
                    Text(article.title)
                        .font(.title)
                        .padding(.top)
                    
                    Text(article.formattedDate)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom)
                }
                .padding(.horizontal)
                
                ScrollView {
                    Text(article.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(article.author)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            Button {
                dismiss.wrappedValue.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
