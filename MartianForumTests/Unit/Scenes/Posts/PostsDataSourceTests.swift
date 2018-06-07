//
//  PostsDataSourceTests.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import XCTest
@testable import MartianForum

class PostsDataSourceTests: XCTestCase {
  func testCreation() {
    let dataSource = PostsDataSource()
    guard let posts = try? PostUserMock.postUsers() else { return XCTFail("The necessary mocks should be successful.") }
    dataSource.addPosts(posts)
    XCTAssertEqual(dataSource.numberOfSections(), 1)
    XCTAssertEqual(dataSource.sections.first?.rows.count, posts.count)
    
    dataSource.addPosts(posts)
    XCTAssertEqual(dataSource.numberOfSections(), 1)
    XCTAssertEqual(dataSource.sections.first?.rows.count, posts.count)
  }
}
