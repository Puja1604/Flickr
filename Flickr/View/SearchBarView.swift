//
//  SearchBarView.swift
//  Flickr
//
//  Created by Puja Gogineni on 7/11/24.
//

import SwiftUI

struct SearchBarView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    
    // Coordinator class to act as the delegate for the UISearchBar
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    // Create an instance of the Coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    // Create and configure the UISearchBar
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        return searchBar
    }
    
    // Update the UISearchBar when the SwiftUI state changes
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}


