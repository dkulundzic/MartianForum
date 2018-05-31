//
//  Comment.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct Comment: Requestable {
  static var resource: ResourceProtocol {
    return Resource.comments(nil)    
  }
  
  let id: Int
  let postId: Int
  let name: String
  let email: String
  let body: String
}
