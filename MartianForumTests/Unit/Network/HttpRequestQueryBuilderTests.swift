//
//  HttpRequestQueryBuilderTests.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import XCTest
@testable import MartianForum

class HttpRequestQueryBuilderTests: XCTestCase {
  func testBuildingWithIntValues() {
    let value1 = 1
    let value2 = 2
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "test1", value: value1)
      .addQuery(key: "test2", value: value2)
      .query()
    XCTAssertEqual(query.count, 2)
    XCTAssertEqual(query[safe: 0]?.value, "\(value1)")
    XCTAssertEqual(query[safe: 1]?.value, "\(value2)")
  }
  
  func testBuildingWithStringValues() {
    let value1 = "1"
    let value2 = "2"
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "test1", value: value1)
      .addQuery(key: "test2", value: value2)
      .query()
    XCTAssertEqual(query.count, 2)
    XCTAssertEqual(query[safe: 0]?.value, value1)
    XCTAssertEqual(query[safe: 1]?.value, value2)
  }
  
  func testBuildingWithNilValues() {
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "test1", value: nil)
      .addQuery(key: "test2", value: nil)
      .query()
    XCTAssertNil(query[safe: 0]?.value)
    XCTAssertNil(query[safe: 1]?.value)
  }
}
