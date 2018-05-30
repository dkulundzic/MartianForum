//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class RequestDispatcher {
  private let baseUrl: URL
  private let jsonEncoder = JSONEncoder()
  private let jsonDecoder = JSONDecoder()
  private let requestSerializer: RequestJSONSerializer = RequestJSONSerializer()
  
  init(baseUrl: URL) {
    self.baseUrl = baseUrl
  }
}

extension RequestDispatcher {
  func request<T: Codable>(using resource: ResourceProtocol, body: T, success: ArgumentlessCompletion, failure: FailureCompletion) {
    let url = baseUrl.appendingPathComponent(resource.endpoint)
    let request = requestSerializer.serialize(request: URLRequest(url: url))
    let dataTask = URLSession.shared.dataTask(with: request) { _, response, error in
      if let error = error {
        failure?(NetworkError.wrapped(error)); return
      }
      guard let response = response as? HTTPURLResponse, RequestStatusCode.valid.contains(response.statusCode) else {
        failure?(NetworkError.generic); return
      }
      success?()
    }
    dataTask.resume()
  }
  
  func request<T: Codable>(using resource: ResourceProtocol, requestMethod: RequestMethod = .get, success: SuccessCompletion<T>, failure: FailureCompletion) {
    let url = baseUrl.appendingPathComponent(resource.endpoint)
    let request = requestSerializer.serialize(request: URLRequest(url: url))
    let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
      if let error = error {
        failure?(NetworkError.wrapped(error)); return
      }
      guard let data = data, let entity = try? self.jsonDecoder.decode(T.self, from: data) else {
        failure?(NetworkError.invalidData); return
      }
      success?(entity)
    }
    dataTask.resume()
  }
}
