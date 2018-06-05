//
//  AlbumsSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum AlbumsSection: SectionProtocol {
  case photo(AlbumHeaderReusableView.ViewModel, [AlbumsRow])
  
  var rows: [AlbumsRow] {
    switch self {
    case .photo(_, let rows):
      return rows
    }
  }
}
