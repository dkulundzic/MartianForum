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
    return Resource.comments    
  }
  
  let id: Int
  let postId: Int
  let name: String
  let email: String
  let body: String
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(postId, forKey: .postId)
    try container.encode(name, forKey: .name)
    try container.encode(email, forKey: .email)
    try container.encode(body, forKey: .body)
  }
}
