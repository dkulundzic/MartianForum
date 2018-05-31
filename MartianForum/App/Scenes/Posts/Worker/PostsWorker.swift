//
//  PostsWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 31/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PostsWorker {
  func getPosts(success: SuccessCompletion<[Post]>, failure: FailureCompletion) {
    RestfulNetworkService<Post>().get(success: success, failure: failure)
  }
}
