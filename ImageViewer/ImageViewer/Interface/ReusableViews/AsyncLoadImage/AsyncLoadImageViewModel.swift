//
//  AsyncLoadImageViewModel.swift
//  ImageViewer
//
//  Created by Sourav on 11/05/24.
//

import Foundation
import SwiftUI

@MainActor
class AsyncLoadImageViewModel: ObservableObject {
    
    let url: String
    @Published var image: UIImage? = nil
    var task: Task<Void, Error>?
    
    init(url: String) {
        self.url = url
    }
    
    func loadImage() {
        
        guard image == nil else  { return } // return if image is already loaded and available
        
        if let cachedImage = ImageCache.shared.getImage(forKey: url) {
            self.image = cachedImage
            return
        }
        
        task = Task {
            print("Hitting Url: \(url)")
            let data = try? await NetworkManager.shared.request(from: url)
            guard let data, let uiImage = UIImage(data: data) else {
                print("Error Loading Image")
                return }
            image = uiImage
            ImageCache.shared.setImage(uiImage, forKey: url)
        }
        
    }
    
    func cancelTask() {
        
        task?.cancel()
        task = nil
    }
    
}
