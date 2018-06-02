//
//  PostsWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Promises

class PostsWorker {
  func getPosts() -> Promise<[PostUser]> {
    return all(RestfulNetworkService<User>().getAll(), RestfulNetworkService<Post>().getAll()).then { data -> [PostUser] in
      let users = data.0
      let posts = data.1
      return posts.compactMap { post in
        guard let user = users.first(where: { $0.id == post.userId }) else { return nil }
        return PostUser(post: post, user: user)
      }
    }
  }
  
  func createPost(_ post: Post) -> Promise<Post> {
    return RestfulNetworkService<Post>().post(model: post)
  }
}
