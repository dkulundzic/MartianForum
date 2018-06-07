//
//  TodosDataSource.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

class TodosDataSource: DataSourceProtocol {
  var sections = [TodosSection]()
  private(set) var enteredText: String?
  private var pendingTodos = [Todo]()
  private var completedTodos = [Todo]()
  private let throttler = Throttler(queue: .main, delay: 0.3)
  
  init() {
    buildSections()
  }
}

extension TodosDataSource {
  func add(todos: [Todo]) {
    pendingTodos = todos.filter { !$0.completed }
    completedTodos = todos.filter { $0.completed }
    buildSections()
  }
  
  func add(todo: Todo) -> IndexPath {
    todo.completed ? completedTodos.insert(todo, at: 0):
      pendingTodos.insert(todo, at: 0)
    buildSections()
    return IndexPath(item: 0, section: todo.completed ? 1: 0)
  }
  
  func todo(at indexPath: IndexPath) -> Todo? {
    return (indexPath.section == 0 ? pendingTodos: completedTodos)[safe: indexPath.item]
  }
  
  func update(updatedTodo: Todo) -> (sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)? {
    guard let sourceIndexPath = indexPath(where: { $0.id == updatedTodo.id }) else {
      return nil
    }
    
    let destinationIndexPath = updatedTodo.completed ? updateTodoToCompleted(indexPath: sourceIndexPath):
      updateTodoToPending(indexPath: sourceIndexPath)
    
    return (sourceIndexPath, destinationIndexPath)
  }
  
  func remove(todo: Todo) -> IndexPath? {
    let todos = todo.completed ? completedTodos: pendingTodos
    guard let indexOf = todos.index(of: todo) else { return nil }
    
    if todo.completed {
      completedTodos.remove(at: indexOf)
    } else {
      pendingTodos.remove(at: indexOf)
    }
    
    buildSections()
    return IndexPath(item: indexOf, section: todo.completed ? 1: 0)
  }
  
  func preserveEnteredText(_ text: String?) {
    throttler.execute { [weak self] in
      self?.enteredText = text
      self?.buildSections()
    }
  }

  func containsPending() -> Bool {
    guard let pendingSection = sections.first else {
      return false
    }
    return !pendingSection.rows.isEmpty
  }
  
  func containsCompleted() -> Bool {
    guard let completedSection = sections[safe: 1] else {
      return false
    }
    return !completedSection.rows.isEmpty
  }
}

private extension TodosDataSource {
  func buildSections() {
    sections.removeAll()
    
    let pendingItems = pendingTodos.filter({ !$0.completed }).map {
      TodosRow.todo(TodosCell.ViewModel(title: $0.title, completed: $0.completed), $0)
    }
    let completedItems = completedTodos.filter({ $0.completed }).map {
      TodosRow.todo(TodosCell.ViewModel(title: $0.title, completed: $0.completed), $0)
    }
    
    sections.append(.pending(TodosInputHeader.ViewModel(enteredText: enteredText), pendingItems))
    sections.append(.completed(TodosSectionHeader.ViewModel(title: "todos_completed_section_header_title".localized()), completedItems))
  }
  
  func updateTodoToPending(indexPath: IndexPath) -> IndexPath {
    let removedTodo = completedTodos.remove(at: indexPath.item)
    let updatedTodo = Todo(id: removedTodo.id, userId: removedTodo.userId, title: removedTodo.title, completed: false)
    pendingTodos.insert(updatedTodo, at: 0)
    buildSections()
    return IndexPath(item: 0, section: 0)
  }
  
  func updateTodoToCompleted(indexPath: IndexPath) -> IndexPath {
    let removedTodo = pendingTodos.remove(at: indexPath.item)
    let updatedTodo = Todo(id: removedTodo.id, userId: removedTodo.userId, title: removedTodo.title, completed: true)
    completedTodos.insert(updatedTodo, at: 0)
    buildSections()
    return IndexPath(item: 0, section: 1)
  }
  
  func indexPath(for todo: Todo) -> IndexPath? {
    if let indexOf = pendingTodos.index(of: todo) {
      return IndexPath(item: indexOf, section: 0)
    } else if let indexOf = completedTodos.index(of: todo) {
      return IndexPath(item: indexOf, section: 1)
    }
    return nil
  }
  
  func indexPath(where: (Todo) -> Bool) -> IndexPath? {
    if let indexOf = pendingTodos.index(where: `where`) {
      return IndexPath(item: indexOf, section: 0)
    } else if let indexOf = completedTodos.index(where: `where`) {
      return IndexPath(item: indexOf, section: 1)
    }
    return nil
  }
}
