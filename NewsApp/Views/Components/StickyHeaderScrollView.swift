//
//  StickyHeaderScrollView.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

struct StickyHeaderScrollView<Image: View, Title: View, Contents: View>: View {

    @EnvironmentObject var animations: AnimationStates

    private let image: Image
    private let title: Title
    private let contents: Contents

    private var maxHeight: CGFloat
    private var minHeight: CGFloat {
        maxHeight/1.4
    }

    private var padding: CGFloat {
        if title is EmptyView {
            return maxHeight - 20
        } else {
            return maxHeight + 130
        }
    }

    init(@ViewBuilder image: () -> Image, @ViewBuilder title: () -> Title, @ViewBuilder contents: () -> Contents, maxHeight: CGFloat = 200) {
        self.image = image()
        self.title = title()
        self.contents = contents()
        self.maxHeight = maxHeight
    }

    init(image: () -> Image, contents: () -> Contents, maxHeight: CGFloat = 200) where Title == EmptyView {
        self.init(image: image, title: {EmptyView()}, contents: contents, maxHeight: maxHeight)
    }

    var body: some View {
        ScrollView {
            ZStack {

                // Body
                contents
                    .padding(.top, padding)

                // Header
                GeometryReader { reader in
                    VStack(spacing: 0) {
                        image
                            .frame(width: reader.size.width, height: self.calculateHederHeight(minHeight: self.minHeight, maxHeight: self.maxHeight, verticalOffset: reader.frame(in: .global).origin.y), alignment: .center)
                            .clipped()
                            .offset(y: reader.frame(in: .global).origin.y < 0 ? abs(reader.frame(in: .global).origin.y) : -reader.frame(in: .global).origin.y)

                        title
                            .offset(y: reader.frame(in: .global).origin.y < 0 ? abs(reader.frame(in: .global).origin.y) : -reader.frame(in: .global).origin.y)

                        Spacer()
                    }
                }
            }
        }
    }

    private func calculateHederHeight(minHeight: CGFloat, maxHeight: CGFloat, verticalOffset: CGFloat) -> CGFloat {
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
