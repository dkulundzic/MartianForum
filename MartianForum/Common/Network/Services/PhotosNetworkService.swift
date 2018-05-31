//
//  PhotosNetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class PhotosNetworkService: RestfulNetworkService {
  func get(id: Int, success: SuccessCompletion<Photo?>, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: Resource.photos(id), requestMethod: .get, success: success, failure: failure)
  }
  
  func delete(id: Int, success: ArgumentlessCompletion, failure: FailureCompletion) {
    HttpRequestDispatcher(baseUrl: URLs.apiURL)
      .request(using: Resource.photos(id), requestMethod: .delete, success: success, failure: failure)
  }
}
