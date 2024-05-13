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
        
        task = Task.detached { [self] in
            print("Downloading from Url: \(url)")
            do {
                
                let data = try await NetworkManager.shared.request(from: url)
                guard let uiImage = UIImage(data: data) else {
                    print("Error parsing Image")
                    await updateImage()
                    return }
                await updateImage(uiImage: uiImage)
                ImageCache.shared.setImage(uiImage, forKey: url)
            } catch (let error){
                
                let urlError =  error as? URLError
                if urlError?.code.rawValue != -999 {
                    
                    print("Error Downloading Image: \(error)")
                    await updateImage()
                }
            }
        }
        
    }
    
    
    private func updateImage(uiImage: UIImage? = nil) {
        if let uiImage {
            image = uiImage
        } else {
            image = UIImage(systemName: "exclamationmark.triangle.fill")
        }
    }
    func cancelTask() {
        if task != nil {
            print("Download Cancelled")
            task?.cancel()
            task = nil
        }
       
    }
    
}
