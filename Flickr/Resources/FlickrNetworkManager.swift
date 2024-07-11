//
//  FlickrNetworkManager.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import Foundation

protocol FlickrNetworkManaging {
    func fetchImages(for tags: String) async throws -> [FlickrPhoto]
}

class FlickrNetworkManager: FlickrNetworkManaging {
    func fetchImages(for tags: String) async throws -> [FlickrPhoto] {
        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(FlickrResponse.self, from: data)
        return response.items
    }
}

