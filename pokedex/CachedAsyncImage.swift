//
//  CachedAsyncImage.swift
//  pokedex
//
//  Created by Daniele Perrupane on 31/07/24.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

struct CachedAsyncImage: View {
    let url: URL?
    
    @State private var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        guard let url = url else { return }
        
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            self.uiImage = cachedImage
        } else {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.setImage(image, for: url)
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                }
            }
            task.resume()
        }
    }
}