//
//  PostsNetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct PostsNetworkService: RestfulNetworkService {
  func get(id: Int, success: SuccessCompletion<Post?>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: Resource.posts(id), requestMethod: .get, success: success, failure: failure)
  }
  
  func delete(id: Int, success: ArgumentlessCompletion, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: Resource.posts(id), requestMethod: .delete, success: success, failure: failure)
  }
}
