//
//  FlickrViewModel.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import Foundation

@MainActor
class FlickrViewModel: ObservableObject {
    
    @Published var images: [FlickrPhoto] = []
    @Published var isLoading: Bool = false
    
    private var networkManager: FlickrNetworkManaging
    
    // Initializer to initialize the view model with a network manager
    init(networkManager: FlickrNetworkManaging = FlickrNetworkManager()) {
        self.networkManager = networkManager
    }
    
    // Async function to fetch images based on tags
    func fetchImages(for tags: String) async {
        isLoading = true
        do {
            let images = try await networkManager.fetchImages(for: tags)
            self.images = images
        } catch {
            print("Failed to fetch images: \(error)")
        }
        isLoading = false
    }

}
