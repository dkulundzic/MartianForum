//
//  PostsWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PostsWorker {
  func getPosts(success: SuccessCompletion<[PostUser]>, failure: FailureCompletion) {
    // TODO: - Apply pyramid of Doom terminating mechanism.
    RestfulNetworkService<User>().get(success: { users in
      RestfulNetworkService<Post>().get(success: { posts in
        let postsAndUsers: [PostUser] = posts.compactMap { post in
          guard let user = users.first(where: { $0.id == post.userId }) else { return nil }
          return PostUser(post: post, user: user)
        }
        success?(postsAndUsers)
      }, failure: failure)
    }, failure: failure)
  }
  
  func createPost(_ post: Post, success: SuccessCompletion<Post>, failure: FailureCompletion) {
    RestfulNetworkService<Post>().post(model: post, success: success, failure: failure)
  }
}
