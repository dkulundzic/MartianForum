//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class NetworkService<Model: Codable> {
  let requestDispatcher = RequestDispatcher(baseUrl: URLs.apiURL)
  let jsonEncoder = JSONEncoder()
  
  func get(id: String, success: SuccessCompletion<[Model]>, failure: FailureCompletion) {
    
  }
  
  func get(success: SuccessCompletion<[Model]>, failure: FailureCompletion) {
    
  }
  
  func post(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion) {
    
  }
  
  func update(model: Model, success: SuccessCompletion<Model>, failure: FailureCompletion) {
    
  }
  
  func delete(id: String, success: ArgumentlessCompletion, failure: FailureCompletion) {
    
  }
}
