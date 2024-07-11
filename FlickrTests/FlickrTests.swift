//
//  FlickrTests.swift
//  FlickrTests
//
//  Created by Puja Gogineni on 7/11/24.
//

import XCTest
@testable import Flickr

class FlickrTests: XCTestCase {
    var viewModel: FlickrViewModel!
    var networkManagerMock: FlickrNetworkManagerMock!
       
    @MainActor override func setUp() {
           super.setUp()
           networkManagerMock = FlickrNetworkManagerMock()
           viewModel = FlickrViewModel(networkManager: networkManagerMock)
       }
       
       override func tearDown() {
           viewModel = nil
           networkManagerMock = nil
           super.tearDown()
       }
    
    // Test the fetchImages function for successful image fetch
       func testFetchImagesSuccess() async {
           networkManagerMock.shouldReturnError = false
           
           await Task { @MainActor in
               await viewModel.fetchImages(for: "test")
               
               XCTAssertFalse(viewModel.isLoading)
               XCTAssertEqual(viewModel.images.count, 1)
               XCTAssertEqual(viewModel.images.first?.title, "Test Photo")
           }.value
       }
       
    // Test the fetchImages function for failed image fetch
       func testFetchImagesFailure() async {
           networkManagerMock.shouldReturnError = true
           
           await Task { @MainActor in
               await viewModel.fetchImages(for: "test")
               
               XCTAssertFalse(viewModel.isLoading)
               XCTAssertTrue(viewModel.images.isEmpty)
           }.value
       }
}
