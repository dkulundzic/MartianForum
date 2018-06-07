//
//  TodosWorker.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 06/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Promises

class TodosWorker {
  func getTodos() -> Promise<[Todo]> {
    let query = HttpRequestQueryBuilder()
      .addQuery(key: "userId", value: 1)
      .query()
    return RestfulNetworkService<Todo>().getAll(query: query)
  }
  
  func createTodo(_ todo: Todo) -> Promise<Todo> {
    return RestfulNetworkService<Todo>().post(model: todo)
  }
  
  func updateTodo(_ todo: Todo) -> Promise<Todo> {
    return RestfulNetworkService<Todo>().update(id: todo.id, model: todo)
  }
}
