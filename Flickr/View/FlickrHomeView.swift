//
//  FlickrHomeView.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import SwiftUI

struct FlickrHomeView: View {
    @StateObject var viewModel = FlickrViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchText, placeholder: "Search")
                    .padding()
                if viewModel.isLoading {
                    ProgressView()
                        .accessibilityIdentifier("ProgressView")
                } else {
                    ScrollView {
                        // Grid for displaying fetched images
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                            ForEach(viewModel.images) { image in
                                // Navigation link to detail view for each image
                                NavigationLink(destination: DetailView(image: image)) {
                                    AsyncImage(url: image.media.m) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .accessibilityIdentifier("ImageProgressView")
                                        case .success(let image):
                                            // Display the loaded image
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                                                .clipped()
                                                .transition(.scale)
                                                .accessibilityIdentifier("ImageView")
                                        case .failure:
                                            Image(systemName: "photo") 
                                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                                                .foregroundColor(.gray)
                                                .accessibilityIdentifier("ImageView")
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Flickr Search")
            .onChange(of: searchText) { newText, _ in
                // Fetch images when searchText changes
                Task {
                    await viewModel.fetchImages(for:newText)
                }
            }
        }
    }
}

#Preview {
    FlickrHomeView()
}
