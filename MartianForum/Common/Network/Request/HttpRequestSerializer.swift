//
//  RequestSerializer.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol HttpRequestSerializer {
  func serialize(request: URLRequest) -> URLRequest
}
