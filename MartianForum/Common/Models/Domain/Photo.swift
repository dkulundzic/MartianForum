//
//  Photo.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 30/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct Photo: Requestable {
  static var resource: ResourceProtocol {
    return Resource.photos
  }
  
  let id: Int
  let albumId: Int
  let title: String
  let url: URL
  let thumbnailUrl: URL
}
