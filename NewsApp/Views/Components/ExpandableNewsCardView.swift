//
//  ExpandableNewsCardView.swift
//  NewsApp
//
//  Created by leonardo on 21/11/22.
//

import SwiftUI

struct ExpandableNewsCardView: View {
    
    @EnvironmentObject var data: DataStore
    @EnvironmentObject var animations: AnimationStates
    
    @State var article: News
    @State var isExpanded = false
    @State var isCompact = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))
            
            if isCompact {
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
            if isExpanded {
                DetailView()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.top,.horizontal], animations.scaleEffect)
            }
                
        }
        .id(article.id)
        .padding([.top,.horizontal], isExpanded ? 0 : 10)
        .frame(maxWidth: .infinity, minHeight: isExpanded ? UIScreen.main.bounds.height : 150)
        .onTapGesture {
            data.currentArticle = article
            isExpanded ? nil : expand()
        }
        .onChange(of: animations.showDetail, perform: { newValue in
            if !animations.showDetail && isExpanded {
                contract()
            }
        })
    }
    
    func expand() {
        withAnimation(.linear(duration: 0.5)) {
            isCompact = false
            isExpanded = true
            animations.isExpanded = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                animations.scaleEffect = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animations.showDetail = true
        }
    }
    
    func contract() {
        isCompact = true
        withAnimation(.linear(duration: 0.1)) {
            animations.scaleEffect = 10

        }
        withAnimation(.linear(duration: 0.3)) {
            isExpanded = false
            animations.isExpanded = false
        }
    }
}
