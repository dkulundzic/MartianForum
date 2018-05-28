//
//  JSONRequestSerializer.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct RequestJSONSerializer: RequestSerializer {
  func serialize(request: URLRequest) -> URLRequest {
    var mutableRequest = request
    mutableRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    return mutableRequest
  }
}
