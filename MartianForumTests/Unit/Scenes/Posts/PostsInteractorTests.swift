//
//  PostsInteractorTests.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import XCTest
@testable import MartianForum
@testable import Promises

class PostsInteractorTests: XCTestCase {
  private let interactor = PostsInteractor()
  private let presenterInjector = PostsPresenterInjector()
  
  override func setUp() {
    super.setUp()
    interactor.presenter = presenterInjector
  }
  
  override func tearDown() {
    super.tearDown()
    Mocker.removeStubs()
  }
  
  func testLoadPostsSuccess() {
    RestfulStubs<Post>().stubGetRequest()
    interactor.loadPosts()
    
    XCTAssert(waitForPromises(timeout: 5))
    XCTAssertTrue(presenterInjector.wasPresentPostsCalled)
    XCTAssertTrue(presenterInjector.wasPresentNetworkOperationCalled)
    XCTAssertFalse(presenterInjector.wasPresentErrorCalled)
  }
  
  func testLoadPostsFailure() {
    RestfulStubs<Post>().stubGetRequest(responseStatusCode: 400)
    interactor.loadPosts()
    
    XCTAssert(waitForPromises(timeout: 5))
    XCTAssertTrue(presenterInjector.wasPresentErrorCalled)
    XCTAssertTrue(presenterInjector.wasPresentNetworkOperationCalled)
    XCTAssertFalse(presenterInjector.wasPresentPostsCalled)
  }
}

private class PostsPresenterInjector: PostsPresentationLogic {
  var wasPresentPostsCalled = false
  var wasPresentPostCalled = false
  var wasPresentNetworkOperationCalled = false
  var wasPresentErrorCalled = false
  
  func presentPosts(_ posts: [PostUser]) {
    wasPresentPostsCalled = true
  }
  
  func presentPost(_ post: Post, creationResult: Bool) {
    wasPresentPostCalled = true
  }
  
  func presentNetworkOperation(running: Bool) {
    wasPresentNetworkOperationCalled = true
  }
  
  func presentError(_ error: MartianError) {
    wasPresentErrorCalled = true
  }
}
