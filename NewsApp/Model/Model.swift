//
//  Model.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation

struct News {
    let id: Int
    let title: String
    let description: String
    let release_date: String
    let author: String
    let image: String
    
    
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"
        
        if let date: Date = formatter.date(from: self.release_date) {
            return date
        } else {
            return Date.distantPast
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d, ''yy"
        return formatter.string(from: self.date).capitalized
    }
    
    var imageURL: URL {
        if let url: URL = URL(string: image) {
            return url
        } else {
            return URL(string: "https://dummyimage.com/600")!
        }
    }
}
