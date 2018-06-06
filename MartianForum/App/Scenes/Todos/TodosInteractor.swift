//
//  TodosInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol TodosBusinessLogic {
  func loadTodos()
  func createTodo(with title: String)
}

class TodosInteractor {
  var presenter: TodosPresentationLogic?
  lazy var todosWorker = TodosWorker()
}

// MARK: - Business Logic
extension TodosInteractor: TodosBusinessLogic {
  func loadTodos() {
    todosWorker.getTodos().then { [weak self] todos in
      self?.presenter?.presentTodos(todos)
    }.catch { [weak self] error in
      self?.presenter?.presentError(NetworkError.wrapped(error))
    }
  }
  
  func createTodo(with title: String) {
    
  }
}
