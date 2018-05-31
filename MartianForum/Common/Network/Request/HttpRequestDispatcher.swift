//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class HttpRequestDispatcher {
  private let baseUrl: URL
  private let jsonEncoder = JSONEncoder()
  private let jsonDecoder = JSONDecoder()
  private let requestSerializers: [HttpRequestSerializer] = [
    HttpRequestAuthSerializer(),
    HttpRequestJSONSerializer()
  ]
  
  init(baseUrl: URL) {
    self.baseUrl = baseUrl
  }
}

extension HttpRequestDispatcher {
  func request<T: Codable>(using resource: ResourceProtocol, requestMethod: HttpRequest.Method, body: T, success: ArgumentlessCompletion, failure: FailureCompletion) {
    request(resource: resource, requestMethod: requestMethod) { _, response, error in
      if let error = error {
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        failure?(NetworkError.wrapped(error)); return
      }
      
      guard let response = response as? HTTPURLResponse else {
        Logger.error("Encountered an error: \"\(NetworkError.generic.localizedDescription)\".")
        failure?(NetworkError.generic); return
      }
      
      guard HttpRequest.StatusCode.valid.contains(response.statusCode) else {
        let error = NetworkError.invalidStatusCode(response.statusCode)
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        failure?(error); return
      }
      
      Logger.info("\(response.statusCode) \(response.url?.absoluteString ?? "")")
      
      success?()
    }
  }
  
  func request(using resource: ResourceProtocol, requestMethod: HttpRequest.Method, success: ArgumentlessCompletion, failure: FailureCompletion) {
    request(resource: resource, requestMethod: requestMethod) { _, response, error in
      if let error = error {
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        failure?(NetworkError.wrapped(error)); return
      }
      
      guard let response = response as? HTTPURLResponse else {
        Logger.error("Encountered an error: \"\(NetworkError.generic.localizedDescription)\".")
        failure?(NetworkError.generic); return
      }
      
      guard HttpRequest.StatusCode.valid.contains(response.statusCode) else {
        let error = NetworkError.invalidStatusCode(response.statusCode)
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        failure?(error); return
      }
      
      Logger.info("\(response.statusCode) \(response.url?.absoluteString ?? "")")
      
      success?()      
    }
  }
  
  func request<T: Codable>(using resource: ResourceProtocol, requestMethod: HttpRequest.Method, success: SuccessCompletion<T>, failure: FailureCompletion) {
    request(resource: resource, requestMethod: requestMethod) { data, response, error in
      if let error = error {
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        failure?(NetworkError.wrapped(error))
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        Logger.error("Encountered an error: \"\(NetworkError.generic.localizedDescription)\".")
        failure?(NetworkError.generic); return
      }
      
      guard HttpRequest.StatusCode.valid.contains(response.statusCode) else {
        let error = NetworkError.invalidStatusCode(response.statusCode)
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        failure?(error); return
      }
      
      Logger.info("\(response.statusCode) \(response.url?.absoluteString ?? "")")
      
      guard let data = data, let entity = try? self.jsonDecoder.decode(T.self, from: data) else {
        failure?(NetworkError.invalidData); return
      }
      
      success?(entity)
    }
  }
}

private extension HttpRequestDispatcher {
  func request(resource: ResourceProtocol, requestMethod: HttpRequest.Method, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    let url = baseUrl.appendingPathComponent(resource.endpoint(for: requestMethod))
    var request = URLRequest(url: url)
    request.httpMethod = requestMethod.rawValue
    request = requestSerializers.reduce(request, { request, serializer -> URLRequest in
      return serializer.serialize(request: request)
    })
    Logger.info("\(requestMethod.rawValue.uppercased()) \(url)")
    URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
  }
}
