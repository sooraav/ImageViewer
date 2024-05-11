//
//  HomeViewModel.swift
//  ImageViewer
//
//  Created by Sourav on 09/05/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var errorMessage: String? = nil
    @Published var imageUrls: [String]? = nil
    
    
    func getData(for urlString: String = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100") {
        Task {
            do {
                let bases: [Base] = try await NetworkManager.shared.fetch(from: urlString)
                imageUrls = getImageUrls(bases: bases)
            } catch {
                errorMessage = "Network Error"
            }
        }
    }
    
    private func getImageUrls(bases: [Base]) -> [String] {
        
        return bases.map {
            let thumbnail =  $0.thumbnail
            return thumbnail.domain + "/" + thumbnail.basePath + "/0/" + thumbnail.key
        }
    }
    
}
