//
//  Comment.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct Comment: Codable {
  let id: Int
  let postId: Int
  let name: String
  let email: String
  let body: String
}
