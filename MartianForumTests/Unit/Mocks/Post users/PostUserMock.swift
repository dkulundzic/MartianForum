//
//  PostUserMock.swift
//  MartianForumTests
//
//  Created by Domagoj Kulundzic on 08/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation
@testable import MartianForum

struct PostUserMock {
  static func postUsers() throws -> [PostUser] {
    let users = try UsersMock.users()
    let posts = try PostsMock.posts()
    return posts.compactMap { post in
      guard let user = users.first(where: { $0.id == post.userId }) else { return nil }
      return PostUser(post: post, user: user)
    }
  }
}
