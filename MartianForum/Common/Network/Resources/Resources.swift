//
//  Resources.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum Resource: ResourceProtocol {
  case posts(Int?)
  case comments(Int?)
  case todos(Int?)
  case albums(Int?)
  case users(Int?)
  case photos(Int?)
  
  func endpoint(for method: HttpRequest.Method) -> String {
    switch self {
    case .posts(let id):
      return endpoint("posts", byAppendingEntityId: id)
    case .albums(let id):
      return endpoint("albums", byAppendingEntityId: id)
    case .todos(let id):
      return endpoint("todos", byAppendingEntityId: id)
    case .comments(let id):
      return endpoint("comments", byAppendingEntityId: id)
    case .users(let id):
      return endpoint("users", byAppendingEntityId: id)
    case .photos(let id):
      return endpoint("photos", byAppendingEntityId: id)
    }
  }
}

private extension Resource {
  func endpoint(_ endpoint: String, byAppendingEntityId id: Int?) -> String {
    guard let id = id else {
      return endpoint
    }
    return endpoint.appending("/\(id)")
  }
}
