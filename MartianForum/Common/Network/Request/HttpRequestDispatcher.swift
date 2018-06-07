//
//  NetworkService.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum HttpRequestDispatcherError: MartianError {
  case invalidUrl(URL)
  case invalidQuery
  
  var localisedTitle: String? {
    switch  self {
    case .invalidUrl, .invalidQuery:
      return "Error"
    }
  }
  
  var errorDescription: String? {
    switch self {
    case .invalidUrl(let url):
      return "The passed-in url \"\(url)\" is invalid."
    case .invalidQuery:
      return "The passed-in query parameters are invalid."
    }
  }
}

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
  func request<T: Codable>(using path: String, requestMethod: HttpRequest.Method, body: T, success: SuccessCompletion<T>, failure: FailureCompletion) {
    request(path: path, requestMethod: requestMethod, body: try? jsonEncoder.encode(body)) { data, response, error in
      if let error = error {
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(NetworkError.wrapped(error))
        }
      }
      
      guard let response = response as? HTTPURLResponse else {
        Logger.error("Encountered an error: \"\(NetworkError.generic.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(NetworkError.generic)
        }
      }
      
      guard HttpRequest.StatusCode.valid.contains(response.statusCode) else {
        let error = NetworkError.invalidStatusCode(response.statusCode)
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(error)
        }
      }
      
      Logger.info("\(response.statusCode) \(response.url?.absoluteString ?? "")")
      
      guard let data = data, let entity = try? self.jsonDecoder.decode(T.self, from: data) else {
        return self.invokeOnMain {
          failure?(NetworkError.invalidData(T.self))
        }
      }
      
      self.invokeOnMain { success?(entity) }
    }
  }
  
  func request(using path: String, requestMethod: HttpRequest.Method, query: [Query]? = nil, success: ArgumentlessCompletion, failure: FailureCompletion) {
    request(path: path, requestMethod: requestMethod, query: query) { _, response, error in
      if let error = error {
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(NetworkError.wrapped(error))
        }
      }
      
      guard let response = response as? HTTPURLResponse else {
        Logger.error("Encountered an error: \"\(NetworkError.generic.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(NetworkError.generic)
        }
      }
      
      guard HttpRequest.StatusCode.valid.contains(response.statusCode) else {
        let error = NetworkError.invalidStatusCode(response.statusCode)
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(error)
        }
      }
      
      Logger.info("\(response.statusCode) \(response.url?.absoluteString ?? "")")
      
      self.invokeOnMain { success?() }
    }
  }
  
  func request<T: Codable>(using path: String, requestMethod: HttpRequest.Method, query: [Query]? = nil, success: SuccessCompletion<T>, failure: FailureCompletion) {
    request(path: path, requestMethod: requestMethod, query: query) { data, response, error in
      if let error = error {
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(NetworkError.wrapped(error))
        }
      }
      
      guard let response = response as? HTTPURLResponse else {
        Logger.error("Encountered an error: \"\(NetworkError.generic.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(NetworkError.generic)
        }
      }
      
      guard HttpRequest.StatusCode.valid.contains(response.statusCode) else {
        let error = NetworkError.invalidStatusCode(response.statusCode)
        Logger.error("Encountered an error: \"\(error.localizedDescription)\".")
        return self.invokeOnMain {
          failure?(error)
        }
      }
      
      Logger.info("\(response.statusCode) \(response.url?.absoluteString ?? "")")
      
      guard let data = data, let entity = try? self.jsonDecoder.decode(T.self, from: data) else {
        return self.invokeOnMain {
          failure?(NetworkError.invalidData(T.self))
        }
      }
      
      self.invokeOnMain { success?(entity) }
    }
  }
}

private extension HttpRequestDispatcher {
  func request(path: String, requestMethod: HttpRequest.Method, query: [Query]? = nil, body: Data? = nil, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    do {
      let url = try self.url(for: path, requestMethod: requestMethod, query: query)
      
      var request = URLRequest(url: url)
      request.httpMethod = requestMethod.rawValue
      if let body = body, let object = try? JSONSerialization.jsonObject(with: body, options: []) {
        Logger.debug("Request body: \(object)")
      }
      request.httpBody = body
      request = requestSerializers.reduce(request, { request, serializer -> URLRequest in
        return serializer.serialize(request: request)
      })
      
      Logger.info("\(requestMethod.rawValue.uppercased()) \(url)")      
      URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    } catch {
      return completionHandler(nil, nil, NetworkError.wrapped(error))
    }
  }
  
  func url(for path: String, requestMethod: HttpRequest.Method, query: [Query]?) throws -> URL {
    let url = baseUrl.appendingPathComponent(path)
    
    guard let query = query else {
      return url
    }
    
    guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      throw HttpRequestDispatcherError.invalidUrl(url)
    }
    
    components.queryItems = query
    
    guard let componentsUrl = components.url else {
      throw HttpRequestDispatcherError.invalidQuery
    }
    
    return componentsUrl
  }

  func invokeOnMain(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async(execute: closure)
  }
}
