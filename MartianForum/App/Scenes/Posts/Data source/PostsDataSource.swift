//
//  PostsDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct PostsDataSource: DataSourceProtocol {
  var sections = [PostsSection]()
  
  init() {
    buildSections()
  }
}

private extension PostsDataSource {
  func buildSections() {
    
  }
}
