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
  func testGet() {
    let requestExpectation = expectation(description: "GET request.")
    
    RestfulNetworkService<Post>().get(query: nil, success: { _ in
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
    
    RestfulNetworkService<Post>().get(id: 1, query: nil, success: { _ in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testGetWithQuery() {
    let requestExpectation = expectation(description: "GET WITH QUERY request.")
    
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "userId", value: "\(10)")
      .query()
    
    RestfulNetworkService<Post>().get(query: query, success: { _ in
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
    RestfulNetworkService<Post>().post(model: post, success: { _ in
      requestExpectation.fulfill()
    }, failure: { error in
      Logger.error(error.localizedDescription)
      XCTFail("The failure closure should not be called.")
      requestExpectation.fulfill()
    })
    
    waitForExpectations(timeout: 5, handler: nil)
  }
}
