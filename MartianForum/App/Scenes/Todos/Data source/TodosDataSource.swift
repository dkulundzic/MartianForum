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
  
  func updateCompleted(for todo: Todo, at indexPath: IndexPath) -> (updatedTodo: Todo, destinationIndexPath: IndexPath) {
    return !todo.completed ? updateTodoToCompleted(indexPath: indexPath):
      updateTodoToPending(indexPath: indexPath)
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
  
  func updateTodoToPending(indexPath: IndexPath) -> (updatedTodo: Todo, destinationIndexPath: IndexPath) {
    let removedTodo = completedTodos.remove(at: indexPath.item)
    let updatedTodo = Todo(id: removedTodo.id, userId: removedTodo.userId, title: removedTodo.title, completed: false)
    pendingTodos.insert(updatedTodo, at: 0)
    buildSections()
    return (updatedTodo, IndexPath(item: 0, section: 0))
  }
  
  func updateTodoToCompleted(indexPath: IndexPath) -> (updatedTodo: Todo, destinationIndexPath: IndexPath) {
    let removedTodo = pendingTodos.remove(at: indexPath.item)
    let updatedTodo = Todo(id: removedTodo.id, userId: removedTodo.userId, title: removedTodo.title, completed: true)
    completedTodos.insert(updatedTodo, at: 0)
    buildSections()
    return (updatedTodo, IndexPath(item: 0, section: 1))
  }
}
