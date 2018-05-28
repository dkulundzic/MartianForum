//
//  TodosDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

struct TodosDataSource: DataSourceProtocol {
  var sections = [TodosSection]()
  
  init() {
    buildSections()
  }
}

private extension TodosDataSource {
  func buildSections() {
    
  }
}
