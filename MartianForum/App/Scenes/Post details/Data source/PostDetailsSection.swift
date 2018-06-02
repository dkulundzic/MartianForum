//
//  PostDetailsSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum PostDetailsSection: SectionProtocol {
  case postDetails([PostDetailsRow])
  
  var rows: [PostDetailsRow] {
    switch  self {
    case .postDetails(let rows):
      return rows
    }
  }
}
