//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Promises

class RestfulNetworkService<Model: Requestable> {
  var resource: ResourceProtocol {
    return Model.resource
  }
  
  func getWithPromise(query: [Query]? = nil) -> Promise<[Model]> {
    return Promise { fullfill, reject in
      HttpRequestDispatcher(baseUrl: URLs.apiURL)
        .request(using: self.resource.endpoint, requestMethod: .get, query: query, success: fullfill, failure: reject)
    }
  }
  
  func get(id: Int, query: [Query]? = nil)  -> Promise<Model> {
    return Promise { fullfill, reject in
      HttpRequestDispatcher(baseUrl: URLs.apiURL)
        .request(using: "\(self.resource.endpoint)/\(id)", requestMethod: .get, query: query, success: fullfill, failure: reject)
    }
  }
  
  func get(query: [Query]? = nil) -> Promise<[Model]> {
    return Promise { fullfill, reject in
      HttpRequestDispatcher(baseUrl: URLs.apiURL)
        .request(using: self.resource.endpoint, requestMethod: .get, query: query, success: fullfill, failure: reject)
    }
  }
  
  func post(model: Model) -> Promise<Model> {
    return Promise { fullfill, reject in
      HttpRequestDispatcher(baseUrl: URLs.apiURL)
        .request(using: self.resource.endpoint, requestMethod: .post, body: model, success: {
          fullfill(model)
        }, failure: reject)
    }
  }
  
  func update(model: Model) -> Promise<Model> {
    return Promise { fullfill, reject in
      HttpRequestDispatcher(baseUrl: URLs.apiURL)
        .request(using: self.resource.endpoint, requestMethod: .post, body: model, success: {
          fullfill(model)
        }, failure: reject)
    }
  }
  
  func delete(id: Int) -> Promise<Void> {
    return Promise { fullfill, reject in
      HttpRequestDispatcher(baseUrl: URLs.apiURL)
        .request(using: "\(self.resource.endpoint)/\(id)", requestMethod: .delete, success: fullfill, failure: reject)
    }
  }
}
