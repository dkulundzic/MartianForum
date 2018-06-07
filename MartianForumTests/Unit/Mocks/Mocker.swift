//
//  Mocker.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation
import Mockingjay

struct Mocker {
  static func removeStubs() {
    MockingjayProtocol.removeAllStubs()
  }
  
  static func stub(url: String, method: HTTPMethod, responseStatusCode: Int = 200, responseBody: String? = nil) {
    let builder: Builder
    if let responseBody = responseBody, let data = responseBody.data(using: .utf8) {
      builder = jsonData(data, status: responseStatusCode)
    } else {
      builder = http(responseStatusCode, download: .noContent)
    }
    
    MockingjayProtocol.addStub(matcher: http(method, uri: url), builder: builder)
  }
  
  static func loadFile(named: String, type: String = "json") -> String {
    do {
      guard let path = Bundle.main.path(forResource: named, ofType: type) else {
        throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)
      }
      return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
      return ""
    }
  }
  
  static func singleObject<T: Codable>(from file: String) throws -> T {
    if let data = loadFile(named: file).data(using: .utf8) {
      return try JSONDecoder().decode([T].self, from: data)[0]
    } else {
      throw NSError(domain: "", code: NSURLErrorCannotDecodeRawData, userInfo: nil)
    }
  }
  
  static func objects<T: Codable>(from file: String) throws -> T {
    if let data = loadFile(named: file).data(using: .utf8) {
      return try JSONDecoder().decode(T.self, from: data)
    } else {
      throw NSError(domain: "", code: NSURLErrorCannotDecodeRawData, userInfo: nil)
    }
  }
}
