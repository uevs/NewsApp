//
//  ExpandableNewsCardView.swift
//  NewsApp
//
//  Created by leonardo on 21/11/22.
//

import SwiftUI

/// This card can expand on tap to show the details of the news.
///
struct ExpandableNewsCardView: View {
    
    @EnvironmentObject var data: DataStore
    @EnvironmentObject var animations: AnimationStates
    
    @State var article: News
    
    /// Local animation states to manage the expansion of the card and to time animations correctly.
    @State private var isExpanded: Bool = false
    @State private var isExpanding: Bool = false
    @State private var isCompact: Bool = true
    @State private var scaleEffect: Double = 10
    @State private var opacity: Double = 1
    
    private let cardHeight: CGFloat = 450
    private let imageHeight: CGFloat = 250
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemGroupedBackground)
            
            VStack(alignment: .leading) {
                AsyncImageView(url: article.imageURL, id: article.id, placeholder: {
                    Image(systemName: "wifi.exclamationmark")
                        .resizable()
                        .foregroundColor(.red)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                })
                .aspectRatio(contentMode: .fill)
                .frame(height: imageHeight)
                .clipped()
                
                Text(article.title)
                    .font(.title2.weight(.semibold))
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.horizontal,.top])
                
                Text(article.description)
                    .font(.system(size: 16, weight: .light))
                    .truncationMode(.tail)
                    .padding(.top, 3)
                    .padding(.horizontal, isExpanded ? 20 : 16)
                    .padding(.bottom, 10)
                    .opacity(opacity)
                Spacer()
            }
            .padding(.top, isExpanded ? scaleEffect : 0)
            .frame(maxHeight: isExpanded ? .infinity : cardHeight, alignment: .top)
        }
        .id(article.id)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding([.top, .horizontal], isExpanded ? 0 : 10)
        .frame(maxWidth: .infinity, minHeight: isExpanded ? screenHeight : cardHeight, maxHeight: isExpanded ? screenHeight : cardHeight)
        .onTapGesture {
            /// When tapped, it stores the selected article on the ViewModel and starts the expansion process.
            data.currentArticle = article
            isExpanded ? nil : expand()
        }
        .onChange(of: animations.showDetail, perform: { _ in
            /// If the DetailView gets closed by the user, it starts the contraction process.
            if !animations.showDetail {
                contract()
            }
        })
    }
    
    /// Expands the card
    /// Animations and states are timed so they can happen in the right order to ensure a smooth animation
    private func expand() {
        animations.isExpanded = true /// Communicates to other views that a card is expanding
        opacity = 0
        
        withAnimation(.linear(duration: 0.5)) {
            isCompact = false
            isExpanded = true
            isExpanding = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation {
                scaleEffect = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            animations.showDetail = true
        }
    }
    
    /// Contracts the card
    /// Animations and states are timed so they can happen in the right order to ensure a smooth animation
    private func contract() {
        withAnimation(.linear(duration: 0.3)) {
            opacity = 1
        }
        withAnimation(.linear(duration: 0.3)) {
            isCompact = true
            scaleEffect = 10
            isExpanded = false
            animations.isExpanded = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            isExpanding = false
        })
    }
}
