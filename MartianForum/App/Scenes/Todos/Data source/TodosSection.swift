//
//  TodosSection.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

enum TodosSection: SectionProtocol {
  case pending(TodosSectionHeader.ViewModel, [TodosRow])
  case completed(TodosSectionHeader.ViewModel, [TodosRow])
  
  var rows: [TodosRow] {
    switch self {
    case .pending(_, let rows), .completed(_, let rows):
      return rows
    }
  }
}
