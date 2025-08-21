//
//  ImageLoader.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 6/2/25.
//

import SwiftUI

@Observable
final class ImageLoader {

    private enum Constants {
        static let imageCacheFolder: String = "ImageCache"
    }

    var image: Image?
    private var imageURL: URL?

    private let fileManager = FileManager.default
    private let cacheDirectory: URL? = {
        FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(Constants.imageCacheFolder)
    }()

    init() {
        self.createCacheDirectoryIfNeeded()
    }

    func loadImage(with url: URL) {
        imageURL = url
        if let cachedImage = loadImageFromDisk(url: url) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  let data = data,
                  self.imageURL == url,
                  let downloadedImage = UIImage(data: data) else {
                return
            }
            self.saveImageToDisk(image: downloadedImage, url: url)
            DispatchQueue.main.async {
                self.image = Image(uiImage: downloadedImage)
            }
        }.resume()
    }
}

// MARK: Image cache methods

private extension ImageLoader {
    func createCacheDirectoryIfNeeded() {
        guard let cacheDirectory else { return }
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(
                at: cacheDirectory,
                withIntermediateDirectories: true
            )
        }
    }

    func saveImageToDisk(image: UIImage, url: URL) {
        guard let data = image.pngData(),
              let cacheDirectory else { return }
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        try? data.write(to: fileURL)
    }

    func loadImageFromDisk(url: URL) -> Image? {
        guard let cacheDirectory else { return nil }
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        if let img = UIImage(data: data) {
            return Image(uiImage: img)
        }
        return nil
    }
}
