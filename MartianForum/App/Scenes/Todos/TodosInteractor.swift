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
  func updateTodo(_ todo: Todo)
  func deleteTodo(_ todo: Todo)
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
    let todo = Todo(id: -1, userId: 1, title: title, completed: false)
    todosWorker.createTodo(todo).then { [weak self] createdTodo in
      self?.presenter?.presentTodoCreation(createdTodo)
    }.catch { [weak self] error in
        self?.presenter?.presentError(NetworkError.wrapped(error))
    }
  }
  
  func updateTodo(_ todo: Todo) {
    let updatedTodo = Todo(id: todo.id, userId: todo.userId, title: todo.title, completed: !todo.completed)
    todosWorker.updateTodo(updatedTodo).then { [weak self] updatedTodo in
      self?.presenter?.presentTodoUpdate(updatedTodo)
    }.catch { [weak self] error in
      self?.presenter?.presentError(NetworkError.wrapped(error))
    }
  }
  
  func deleteTodo(_ todo: Todo) {
    todosWorker.deleteTodo(todo).then { [weak self] in
      self?.presenter?.presentTodoDeletion(todo)
    }.catch { [weak self] error in
      self?.presenter?.presentError(NetworkError.wrapped(error))
    }
  }
}
