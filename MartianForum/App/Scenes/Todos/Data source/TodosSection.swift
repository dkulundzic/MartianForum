//
//  TodosSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum TodosSection: SectionProtocol {
  case todos([TodosRow])
  
  var rows: [TodosRow] {
    switch self {
    case .todos(let rows):
      return rows
    }
  }
}
