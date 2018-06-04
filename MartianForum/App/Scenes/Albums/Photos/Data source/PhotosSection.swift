//
//  PhotosSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum PhotosSection: SectionProtocol {
  case photos([PhotosRow])
  
  var rows: [PhotosRow] {
    switch self {
    case .photos(let rows):
      return rows
    }
  }
}
