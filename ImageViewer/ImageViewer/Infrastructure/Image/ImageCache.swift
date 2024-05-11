//
//  ImageManager.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    private var memoryCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(forKey key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as NSString) {
            return image
        }
        
        // Check local cache (disk cache)
        if let imageURL = localURL(forKey: key),
           let imageData = try? Data(contentsOf: imageURL),
           let image = UIImage(data: imageData) {
            memoryCache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        
        // Save to local cache (disk cache)
        if let imageURL = localURL(forKey: key),
           let data = image.pngData() {
            try? data.write(to: imageURL, options: [.atomic])
        }
    }
    
    private func localURL(forKey key: String) -> URL? {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return cacheDirectory.appendingPathComponent(key)
    }
}
