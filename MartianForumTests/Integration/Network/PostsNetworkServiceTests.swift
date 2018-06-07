//
//  PostsNetworkServiceTests.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import XCTest
@testable import Promises
@testable import MartianForum

// TODO: - Stub requests
class PostsNetworkServiceTests: XCTestCase {  
  func testGet() {
    let promise = RestfulNetworkService<Post>().getAll()
    XCTAssert(waitForPromises(timeout: 5))
    XCTAssertNil(promise.error)
  }
  
  func testGetById() {
    let promise = RestfulNetworkService<Post>().get(id: 1)
    XCTAssert(waitForPromises(timeout: 5))
    XCTAssertNil(promise.error)
  }
  
  func testGetWithQuery() {
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "userId", value: "\(10)")
      .query()
    let promise = RestfulNetworkService<Post>().getAll(query: query)
    XCTAssert(waitForPromises(timeout: 5))
    XCTAssertNil(promise.error)
  }
  
  func testPost() {
    let post = Post(id: 101, userId: 1, title: "Test post", body: "A new test post")
    let promise = RestfulNetworkService<Post>().post(model: post)
    XCTAssert(waitForPromises(timeout: 5))
    XCTAssertNil(promise.error)
  }
}
