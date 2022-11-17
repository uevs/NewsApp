//
//  NewsCard.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import SwiftUI

struct NewsCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.red)
            
            HStack(alignment: .top) {
                Image(systemName: "wifi.exclamationmark")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text("Realigned multimedia framework")
                        .bold()
                    
                    Text("nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula")
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                Spacer()
            }
            .padding()
        }
        .shadow(color: .gray.opacity(0.5), radius: 20)
        .padding([.top,.horizontal])
        .frame(maxWidth: .infinity, maxHeight: 150)
    }
}

struct NewsCard_Previews: PreviewProvider {
    static var previews: some View {
        NewsCard()
    }
}
