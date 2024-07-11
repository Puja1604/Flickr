//
//  DetailView.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import SwiftUI

struct DetailView: View {
    let image: FlickrPhoto
    
    var body: some View {
        ScrollView {
            VStack {
                // Asynchronously load and display the image from the URL
                AsyncImage(url: image.media.m) { phase in
                    switch phase {
                    case .empty:
                        // Display a progress view while the image is loading
                        ProgressView()
                    case .success(let image):
                        // Display the loaded image
                        image
                            .resizable()
                            .scaledToFit()
                            .transition(.scale)
                            .accessibilityLabel("Image of \(self.image.title)")
                    case .failure:
                        // Display a placeholder image if loading fails
                        Image(systemName: "photo")
                    @unknown default:
                        // Handle any other unexpected cases
                        EmptyView()
                    }
                }
                .frame(height: 300)
                .padding()
                
                Text(image.title)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Title: \(image.title)")
                Text(image.description.htmlToString)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("Description: \(image.description)")
                Text(image.author)
                    .font(.subheadline)
                    .accessibilityLabel("Author: \(image.author)")
                Text(image.published.formattedDate)
                    .font(.subheadline)
                    .accessibilityLabel("Published on \(image.published)")
                
                // Image Dimensions
                if let widthHeight = image.description.extractDimensions() {
                    Text("Dimensions: \(widthHeight.width)x\(widthHeight.height)")
                        .accessibilityLabel("Dimensions: \(widthHeight.width) by \(widthHeight.height)")
                }
                
                // Share Button
                Button(action: shareImage) {
                    Text("Share")
                }
                .padding()
            }
            .padding()
        }
    }
    
    //Share the image and its details
    func shareImage() {
        let url = image.media.m
        let activityVC = UIActivityViewController(activityItems: [url, image.title, image.description], applicationActivities: nil)
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let rootViewController = scene.windows.first?.rootViewController {
                rootViewController.present(activityVC, animated: true)
            }
        }
    }

}
