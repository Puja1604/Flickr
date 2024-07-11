//
//  FlickrPhoto.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import Foundation

struct FlickrPhoto: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    let author: String
    let published: String
    let media: Media
    
    struct Media: Codable {
        let m: URL
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description = "description", author, published = "published", media
    }
}

struct FlickrResponse: Codable {
    let items: [FlickrPhoto]
}
