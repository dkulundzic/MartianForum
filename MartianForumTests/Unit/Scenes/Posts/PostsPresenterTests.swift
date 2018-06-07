//
//  PostsPresenterTests.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import XCTest
@testable import MartianForum

class PostsPresenterTests: XCTestCase {
  private let presenter = PostsPresenter()
  private let displayLogicInjector = PostsViewControllerInjector()
  
  override func setUp() {
    super.setUp()
    presenter.viewController = displayLogicInjector
  }
  
  func testPresentPosts() {
    presenter.presentPosts([])
    
    XCTAssertTrue(displayLogicInjector.wasDisplayPostCalled)
    XCTAssertFalse(displayLogicInjector.wasDisplayErrorCalled)
  }
  
  func testPresentNetworkOperation() {
    presenter.presentNetworkOperation(running: true)
    XCTAssertTrue(displayLogicInjector.wasDisplayNetworkOperationCalled)
  }
  
  func testPresentError() {
    presenter.presentError(NetworkError.generic)
    
    XCTAssertFalse(displayLogicInjector.wasDisplayPostCalled)
    XCTAssertFalse(displayLogicInjector.wasDisplayNetworkOperationCalled)
    XCTAssertTrue(displayLogicInjector.wasDisplayErrorCalled)
    
  }
}

private class PostsViewControllerInjector: PostsDisplayLogic {
  var wasDisplayPostCalled = false
  var wasDisplayNetworkOperationCalled = false
  var wasDisplayErrorCalled = false
  
  func displayPosts(_ posts: [PostUser]) {
    wasDisplayPostCalled = true
  }
  
  func displayNetworkOperation(running: Bool) {
    wasDisplayNetworkOperationCalled = true
  }
  
  func displayError(title: String?, message: String?) {
    wasDisplayErrorCalled = true
  }
}
