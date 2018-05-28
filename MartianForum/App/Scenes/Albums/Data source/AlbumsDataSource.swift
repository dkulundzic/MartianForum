//
//  AlbumsDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct AlbumsDataSource: DataSourceProtocol {
  var sections = [AlbumsSection]()
  
  init() {
    buildSections()
  }
}

private extension AlbumsDataSource {
  func buildSections() {
    
  }
}
