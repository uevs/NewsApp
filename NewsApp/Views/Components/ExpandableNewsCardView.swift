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
    @State var isExpanding = false
    @State var isCompact = true

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.secondarySystemGroupedBackground))

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
            if isExpanding {
                DetailView()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.top], animations.scaleEffect)
                    .padding(.horizontal, isCompact ? 0 : animations.scaleEffect)
                    .frame(maxHeight: isExpanded ? .infinity : 110, alignment: .top)
            }

        }
        .id(article.id)
        .padding([.top, .horizontal], isExpanded ? 0 : 10)
        .frame(maxWidth: .infinity, minHeight: isExpanded ? UIScreen.main.bounds.height : 120, maxHeight: isExpanded ? .infinity : 120)
        .onTapGesture {
            data.currentArticle = article
            isExpanded ? nil : expand()
        }
        .onChange(of: animations.showDetail, perform: { _ in
            if !animations.showDetail {
                contract()
            }
        })
    }

    func expand() {
        animations.isExpanded = true
        withAnimation(.linear(duration: 0.5)) {
            isCompact = false
            isExpanded = true
            isExpanding = true
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
        withAnimation(.linear(duration: 0.2)) {
            isCompact = true
            animations.scaleEffect = 10

        }
        withAnimation(.linear(duration: 0.2)) {
            isExpanded = false
            animations.isExpanded = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                isExpanding = false

            }
        })
    }
}
