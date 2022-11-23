//
//  ImagesStorage.swift
//  NewsApp
//
//  Created by leonardo on 20/11/22.
//

import Foundation
import SwiftUI

/// Responsible for reading and writing images on local storage.
/// Uses the documents folder to store images.
///
class ImagesStorage {

    static let shared = ImagesStorage()
    private let folderName = "images"

    init() {
        setup()
    }

    /// If there is no 'images' folder, it creates one.
    private func setup() {

        guard let url = getFolderUrl() else { return }

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory: \(error)")
            }
        }
    }

    /// Gets the URL for the 'images' folder.
    private func getFolderUrl() -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }

    /// Gets the URL for the requested image.
    private func getImageUrl(imageName: String) -> URL? {
        guard let folderURL = getFolderUrl() else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }

    func saveImage(image: UIImage, imageName: String) {

        guard let data = image.pngData(), let url = getImageUrl(imageName: imageName) else { return }

        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image: \(imageName). Error: \(error)")
        }
    }

    func getImage(imageName: String) -> UIImage? {

        guard let url = getImageUrl(imageName: imageName), FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }

        return UIImage(contentsOfFile: url.path)
    }
}
