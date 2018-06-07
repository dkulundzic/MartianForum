//
//  TodosPresenter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol TodosPresentationLogic {
  func presentTodos(_ todos: [Todo])
  func presentTodoCreation(_ todo: Todo)
  func presentError(_ error: MartianError)
}

class TodosPresenter {
  weak var viewController: TodosDisplayLogic?
}

// MARK: - Presentation Logic
extension TodosPresenter: TodosPresentationLogic {
  func presentTodos(_ todos: [Todo]) {
    viewController?.displayTodos(todos)
  }
  
  func presentTodoCreation(_ todo: Todo) {
    viewController?.displayTodoCreation(todo)
  }
  
  func presentError(_ error: MartianError) {
    viewController?.displayError(error.localisedTitle, message: error.localizedDescription)
  }
}
