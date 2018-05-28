//
//  TodosInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol TodosBusinessLogic {
  
}

class TodosInteractor {
  var presenter: TodosPresentationLogic?
}

// MARK: - Business Logic
extension TodosInteractor: TodosBusinessLogic {
  
}