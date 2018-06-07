//
//  Todo.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct Todo: Requestable, Equatable {
  static var resource: ResourceProtocol {
    return Resource.todos
  }
  
  static func == (lhs: Todo, rhs: Todo) -> Bool {
    return lhs.id == rhs.id
  }
  
  let id: Int
  let userId: Int
  let title: String
  let completed: Bool
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(userId, forKey: .userId)
    try container.encode(title, forKey: .title)
    try container.encode(completed, forKey: .completed)
  }
}
