//
//  HttpRequestAuthSerializer.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct HttpRequestAuthSerializer: HttpRequestSerializer {
  private let authToken = "bWFydGlhbmFuZG1hY2hpbmU="
  
  func serialize(request: URLRequest) -> URLRequest {
    var mutableRequest = request
    mutableRequest.addValue(authToken, forHTTPHeaderField: HttpRequest.Headers.authToken.rawValue)
    return mutableRequest
  }
}
