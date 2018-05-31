//
//  HttpRequestQueryBuilder.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

typealias Query = URLQueryItem

class HttpRequestQueryBuilder {
  private var addedQueries = [Query]()
  
  func addQuery(key: String, value: String?) -> Self {
    addedQueries.append(URLQueryItem(name: key, value: value))
    return self
  }
  
  func query() -> [Query] {
    return addedQueries
  }
}
