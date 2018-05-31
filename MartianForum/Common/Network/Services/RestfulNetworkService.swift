//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class RestfulNetworkService<Model: Requestable> {
  var resource: ResourceProtocol {
    return Model.resource
  }
  
  func get(id: Int, query: [Query]? = nil, success: SuccessCompletion<Model?>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: "\(resource.endpoint)/\(id)", requestMethod: .get, query: query, success: success, failure: failure)
  }
  
  func get(query: [Query]? = nil, success: SuccessCompletion<[Model]>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: resource.endpoint, requestMethod: .get, query: query, success: success, failure: failure)
  }
  
  func post(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: resource.endpoint, requestMethod: .post, body: model, success: { success?(model) }, failure: failure)
  }
  
  func update(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: resource.endpoint, requestMethod: .put, body: model, success: { success?(model) }, failure: failure)
  }
  
  func delete(id: Int, success: ArgumentlessCompletion, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: "\(resource.endpoint)/\(id)", requestMethod: .delete, success: success, failure: failure)
  }
}
