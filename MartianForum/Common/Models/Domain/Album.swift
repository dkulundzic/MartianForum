//
//  Album.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct Album: Requestable {
  static var resource: ResourceProtocol {
    return Resource.albums(nil)
  }
  
  let id: Int
  let userId: Int
  let title: String
}
