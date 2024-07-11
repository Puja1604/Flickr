//
//  FlickrNetworkManagerMock.swift
//  FlickrTests
//
//  Created by Puja Gogineni on 7/11/24.
//

import Foundation
@testable import Flickr

class FlickrNetworkManagerMock: FlickrNetworkManager {
    var shouldReturnError = false
    
    override func fetchImages(for tags: String) async throws -> [FlickrPhoto] {
        if shouldReturnError {
            throw URLError(.badURL)
        }
        
        return [FlickrPhoto(title: "Test Photo", description: "Test Description", author: "Test Author", published: "2024-07-11T10:00:00Z", media: .init(m: URL(string: "https://example.com/image.jpg")!))]
    }
}
