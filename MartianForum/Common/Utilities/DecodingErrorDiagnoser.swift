//
//  DecodingErrorDiagnoser.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class DecodingErrorDiagnoser {
  func diagnose(decodingError: DecodingError) {
    switch decodingError {
    case .valueNotFound(let type, let context):
      print("Value not found for \(type).")
      print("Context: \n\(context.debugDescription)")
    case .typeMismatch(let type, let context):
      print("Type mismatch: \(type).")
      print("Context: \n\(context.debugDescription)")
    case .keyNotFound(let key, let context):
      print("Key not found: \(key.debugDescription).")
      print("Context: \n\(context.debugDescription)")      
    case .dataCorrupted(let context):
      print("Context: \n\(context.debugDescription)")
    }
  }
}
