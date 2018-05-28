//
//  PostsSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum PostsSection: SectionProtocol {
  case posts([PostsRow])
  
  var rows: [PostsRow] {
    switch self {
    case .posts(let rows):
      return rows
    }
  }
}
