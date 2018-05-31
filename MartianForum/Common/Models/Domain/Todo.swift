//
//  Todo.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct Todo: Requestable {
  static var resource: ResourceProtocol {
    return Resource.todos
  }
  
  let id: Int
  let userId: Int
  let title: String
  let completed: Bool
}
