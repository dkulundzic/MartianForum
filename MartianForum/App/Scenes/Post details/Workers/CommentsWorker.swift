//
//  PostDetailsWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Promises

class CommentsWorker {
  func getComments(for post: Int) -> Promise<[Comment]> {
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "postId", value: post)
      .query()
    return RestfulNetworkService<Comment>().getAll(query: query)
  }
}
