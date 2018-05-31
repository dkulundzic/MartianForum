//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol RestfulNetworkService {
  associatedtype Model: Requestable
  var resource: ResourceProtocol { get }
  
  func get(id: Int, success: SuccessCompletion<Model?>, failure: FailureCompletion)
  func get(success: SuccessCompletion<[Model]>, failure: FailureCompletion)
  func post(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion)
  func update(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion)
  func delete(id: Int, success: ArgumentlessCompletion, failure: FailureCompletion)
}

extension RestfulNetworkService {
  var resource: ResourceProtocol {
    return Model.resource
  }
  
  func get(success: SuccessCompletion<[Model]>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: resource, requestMethod: .get, success: success, failure: failure)
  }
  
  func post(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: resource, requestMethod: .post, body: model, success: { success?(model) }, failure: failure)
  }
  
  func update(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: resource, requestMethod: .put, body: model, success: { success?(model) }, failure: failure)
  }
}
