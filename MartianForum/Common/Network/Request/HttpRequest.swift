//
//  HttpRequest.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct HttpRequest {
  enum Method: String {
    case get
    case post
    case put
    case delete
  }
  
  enum Headers: String {
    case contentType = "Content-Type"
    case authToken = "X-Auth"
  }
  
  enum ContentType: String {
    case json = "application/json"
  }
  
  enum StatusCode {
    static var valid: ClosedRange<Int> {
      return 200...299
    }
  }
}
