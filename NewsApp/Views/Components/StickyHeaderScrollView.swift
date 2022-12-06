//
//  StickyHeaderScrollView.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

/// A ScrollView with a sticky header and an optional field for a title that will also stick to the header withouth overlapping it.
///
struct StickyHeaderScrollView<Image: View, Title: View, Contents: View>: View {

    @EnvironmentObject var animations: AnimationStates

    private let image: Image /// The image that goes to the Header
    private let title: Title /// The Title that sticks just beneath the Header
    private let contents: Contents /// The contents of the ScrollView

    /// maxHeight of the Header  is default to 200 and can be set when using the view. minHeight is relative to maxHeight.
    private var maxHeight: CGFloat
    private var minHeight: CGFloat {
        maxHeight/1.4
    }

    /// The padding between the Header and the ScrollView contents.
    private var padding: CGFloat {
        if title is EmptyView {
            return maxHeight - 20
        } else {
            return maxHeight + 110
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

                /// The ScrollView Contents are going here.
                contents
                    .padding(.top, padding)

                /// The Sticky Header and optional Title.
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

    /// Returns the height of the header based on the current scroll position.
    private func calculateHederHeight(minHeight: CGFloat, maxHeight: CGFloat, verticalOffset: CGFloat) -> CGFloat {

        /// The verticalOffset is a negative number while scrolling up.
        if maxHeight + verticalOffset < minHeight {

            /// The user is scrolling up, if it reaches the minHeight it stops.
            return minHeight
        } else if maxHeight + verticalOffset > maxHeight {

            /// It dampens the offset the further down the user goes.
            return maxHeight + (verticalOffset * 0.5)
        }

        /// The user is scrolling down.
        return maxHeight + verticalOffset
    }
}
