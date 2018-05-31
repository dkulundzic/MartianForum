//
//  PostsNetworkServiceTests.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import XCTest
@testable import MartianForum

class PostsNetworkServiceTests: XCTestCase {
  private let service = PostsNetworkService()
  
  func testGet() {
    let requestExpectation = expectation(description: "GET request.")
    
    service.get(success: { _ in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testGetById() {
    let requestExpectation = expectation(description: "GET BY ID request.")
    
    service.get(id: 1, success: { post in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testPost() {
    let requestExpectation = expectation(description: "POST request.")
    
    let post = Post(id: 101, userId: 1, title: "Test post", body: "A new test post")
    service.post(model: post, success: { post in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testUpdate() {
    let requestExpectation = expectation(description: "UPDATE request.")
    
    service.get(success: { _ in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testDelete() {
    let requestExpectation = expectation(description: "GET request.")
    
    service.get(success: { _ in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
}
