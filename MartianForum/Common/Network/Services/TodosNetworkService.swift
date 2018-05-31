//
//  TodosNetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct TodosNetworkService: RestfulNetworkService {
  func get(id: Int, success: SuccessCompletion<Todo?>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: Resource.todos(id), requestMethod: .get, success: success, failure: failure)
  }
  
  func delete(id: Int, success: ArgumentlessCompletion, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: Resource.todos(id), requestMethod: .delete, success: success, failure: failure)
  }
}
