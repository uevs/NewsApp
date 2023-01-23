//
//  PersistenceHandler.swift
//  NewsApp
//
//  Created by leonardo on 23/01/23.
//

import Foundation
import SwiftUI

protocol PersistenceHandler {
    func saveImage(image: UIImage, imageName: String, folder: String)
    func getImage(imageName: String, folder: String) -> UIImage?
}
