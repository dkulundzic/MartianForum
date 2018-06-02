//
//  NetworkError.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum NetworkError: MartianError {
  case wrapped(Error)
  case custom(String)
  case invalidStatusCode(Int)
  case generic
  case noInternetConnection
  case invalidData(Any.Type)
  
  var localisedTitle: String? {
    switch self {
    case .generic, .noInternetConnection, .wrapped, .custom, .invalidData, .invalidStatusCode:
      return "Error"
    }
  }
  
  var errorDescription: String? {
    switch self {
    case .generic:
      return "A network error occurred."
    case .noInternetConnection:
      return "No internet connection."
    case .invalidData(let type):
      return "\(type) data in invalid format."
    case .invalidStatusCode(let statusCode):
      return "The server responded with an invalid status code {\(statusCode)}."
    case .wrapped(let error):
      return error.localizedDescription
    case .custom(let errorMessage):
      return errorMessage
    }
  }
}
