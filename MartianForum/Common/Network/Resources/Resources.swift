//
//  Resources.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum Resource: ResourceProtocol {
  case posts
  case comments
  case todos
  case albums
  case users
  case photos
  
  var endpoint: String {
    switch self {
    case .posts:
      return "posts"
    case .albums:
      return "albums"
    case .todos:
      return "todos"
    case .comments:
      return "comments"
    case .users:
      return "users"
    case .photos:
      return "photos"
    }
  }
}
