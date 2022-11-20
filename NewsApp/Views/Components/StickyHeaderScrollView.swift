//
//  StickyHeaderScrollView.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import SwiftUI

struct StickyHeaderScrollView<Image: View, Title: View, Contents: View>: View {
    
    let image: Image
    let title: Title
    let contents: Contents
    
    var padding: CGFloat {
        if title is EmptyView {
            return 120
        } else {
            return 220
        }
    }
    
    init(@ViewBuilder image: () -> Image, @ViewBuilder title: () -> Title, @ViewBuilder contents: () -> Contents) {
        self.image = image()
        self.title = title()
        self.contents = contents()
    }
    
    init(image: () -> Image, contents: () -> Contents) where Title == EmptyView {
        self.init(image: image, title: {EmptyView()}, contents: contents)
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
                            .frame(width: reader.size.width, height: self.calculateHederHeight(minHeight: 100, maxHeight: 150, verticalOffset: reader.frame(in: .global).origin.y), alignment: .center)
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

//struct StickyHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        StickyHeaderScrollView()
//    }
//}
