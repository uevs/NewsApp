//
//  Model.swift
//  NewsApp
//
//  Created by leonardo on 17/11/22.
//

import Foundation

/// The data model of the application.
///
struct News: Codable, Identifiable, Equatable {

    let id: Int
    let title: String
    let description: String
    let release_date: String
    let author: String
    let image: String

    /// Returns the Date from the  'release_date' String.
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy"

        if let date: Date = formatter.date(from: self.release_date) {
            return date
        } else {
            return Date.distantPast
        }
    }

    /// Returns the Date in the required format.
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d, ''yy"
        return formatter.string(from: self.date).capitalized
    }

    /// Returns the URL from the 'image' String.
    var imageURL: URL {
        if let url: URL = URL(string: image) {
            return url
        } else {
            return URL(string: "https://dummyimage.com/600")!
        }
    }
}
