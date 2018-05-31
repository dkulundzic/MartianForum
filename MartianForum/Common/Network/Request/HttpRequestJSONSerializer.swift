//
//  JSONRequestSerializer.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct HttpRequestJSONSerializer: HttpRequestSerializer {
  func serialize(request: URLRequest) -> URLRequest {
    var mutableRequest = request
    mutableRequest.addValue(HttpRequest.ContentType.json.rawValue, forHTTPHeaderField: HttpRequest.Headers.contentType.rawValue)
    return mutableRequest
  }
}
