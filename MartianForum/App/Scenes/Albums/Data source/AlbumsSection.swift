//
//  AlbumsSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum AlbumsSection: SectionProtocol {
  case photo([AlbumsRow])
  
  var rows: [AlbumsRow] {
    switch self {
    case .photo(let rows):
      return rows
    }
  }
}
