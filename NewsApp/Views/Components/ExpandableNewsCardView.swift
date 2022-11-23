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

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))

            /// The 'card' version of the view shown inside the ScrollView in a compact form.
            if isCompact {
                HStack(alignment: .center) {
                    AsyncImageView(url: article.imageURL, id: article.id, placeholder: {
                        Image(systemName: "wifi.exclamationmark")
                            .resizable()
                            .foregroundColor(.red)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    })
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    .padding(.horizontal, 6)

                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.headline.weight(.medium))

                        Text(article.description)
                            .font(.system(size: 15, weight: .light))
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .padding(.trailing)
                    }
                    .frame(height: 100)
                    Spacer()
                }
                .frame(height: 100)
                .padding(6)

            }

            /// The 'expanded' version of the card. This is not interactable and is loaded to make a smooth transitiona animation. The actual DetailView that the user can interact with is then loaded on ContentView
            if isExpanding {
                DetailView()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.top], scaleEffect)
                    .padding(.horizontal, isCompact ? 0 : scaleEffect)
                    .frame(maxHeight: isExpanded ? .infinity : 110, alignment: .top)
                    .opacity(opacity)
            }

        }
        .id(article.id)
        .padding([.top, .horizontal], isExpanded ? 0 : 10)
        .frame(maxWidth: .infinity, minHeight: isExpanded ? UIScreen.main.bounds.height : 120, maxHeight: isExpanded ? .infinity : 120)
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
        opacity = 1
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
            opacity = 0
        }
        withAnimation(.linear(duration: 0.3)) {
            isCompact = true
            scaleEffect = 10
            isExpanded = false
            animations.isExpanded = false

        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            withAnimation {
                isExpanding = false
            }
        })
    }
}
