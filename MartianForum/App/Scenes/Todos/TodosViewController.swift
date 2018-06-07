//
//  TodosViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit
import Promises

protocol TodosDisplayLogic: class {
  func displayTodos(_ todos: [Todo])
  func displayTodoCreation(_ todo: Todo)
  func displayTodoUpdate(_ updatedTodo: Todo)
  func displayTodoDeletion(_ todo: Todo)
  func displayError(_ title: String?, message: String?)
}

class TodosViewController: UICollectionViewController {
  var interactor: TodosBusinessLogic?
  var router: TodosRoutingLogic?
  private let dataSource = TodosDataSource()
  
  private var itemSize: CGSize {
    guard let collectionView = collectionView,
      let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
        return .zero
    }
    
    let contentInsetWidth = collectionView.contentInset.left  + collectionView.contentInset.right
    let sectionInsetWidth = flowLayout.sectionInset.left + flowLayout.sectionInset.right
    
    return CGSize(
      width: collectionView.bounds.width - contentInsetWidth - sectionInsetWidth,
      height: 60
    )
  }
  
  init(delegate: TodosRouterDelegate?) {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    let interactor = TodosInteractor()
    let presenter = TodosPresenter()
    let router = TodosRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()
    interactor.loadTodos()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
}

// MARK: - Display Logic
extension TodosViewController: TodosDisplayLogic {
  func displayTodos(_ todos: [Todo]) {
    dataSource.add(todos: todos)
    collectionView?.reloadData()
  }
  
  func displayTodoCreation(_ todo: Todo) {
    let insertionIndexPath = dataSource.add(todo: todo)
    _ = collectionView?.performBatchUpdates {
      self.collectionView?.insertItems(at: [insertionIndexPath])
      }.then {
        self.collectionView?.reloadData()
    }
  }
  
  func displayTodoUpdate(_ updatedTodo: Todo) {
    guard let updateData = dataSource.update(updatedTodo: updatedTodo) else {
      collectionView?.reloadData()
      return
    }
    
    collectionView?.performBatchUpdates {
      self.collectionView?.moveItem(at: updateData.sourceIndexPath, to: updateData.destinationIndexPath)
    }.then {
      self.collectionView?.reloadItems(at: [updateData.destinationIndexPath])
    }.then {
      self.collectionView?.reloadData()
    }
  }
  
  func displayTodoDeletion(_ todo: Todo) {
    guard let deletionIndexPath = dataSource.remove(todo: todo) else {
      return
    }
    _ = collectionView?.performBatchUpdates {
      self.collectionView?.deleteItems(at: [deletionIndexPath])
      }.then {
        self.collectionView?.reloadData()
    }
  }
  
  func displayError(_ title: String?, message: String?) {
    UIAlertController
      .generic(title: title, message: message)
      .present(on: self)
  }
}

// MARK: - UICollectionViewDataSource
extension TodosViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let row = dataSource.row(at: indexPath) else {
      return UICollectionViewCell()
    }
    
    switch row {
    case .todo(let viewModel, let todo):
      let cell = collectionView.dequeueReusableCell(TodosCell.self, at: indexPath)
      cell.update(viewModel)
      cell.handler = { [weak self] cell in
        self?.didSelectTodo(todo, from: cell)
      }
      cell.deletionHandler = { [weak self] in
        self?.didInvokeTodoDeletion(at: indexPath)
      }
      return cell
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let section = dataSource.section(at: indexPath.section), kind == UICollectionElementKindSectionHeader else { return UICollectionReusableView() }
    
    switch section {
    case .pending(let viewModel, _):
      let sectionHeader: TodosInputHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, forIndexPath: indexPath)
      sectionHeader.update(viewModel)
      sectionHeader.inputHandler = { [weak self] input in
        self?.dataSource.preserveEnteredText(input)
      }
      sectionHeader.returnHandler = { [weak self] textField in
        self?.didInvokeTodoCreation(textField: textField)
      }
      return sectionHeader
    case .completed(let viewModel, _):
      let sectionHeader: TodosSectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, forIndexPath: indexPath)
      sectionHeader.update(viewModel)
      return sectionHeader
    }
  }
}

// MARK: - UICollectionViewDelegate
extension TodosViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return itemSize
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    guard let section = dataSource.section(at: section) else { return .zero }
    
    switch section {
    case .pending:
      return CGSize(width: itemSize.width, height: 60)
    case .completed:
      return CGSize(width: itemSize.width, height: 40)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    guard let section = dataSource.section(at: section) else { return .zero }
    
    switch section {
    case .pending:
      return UIEdgeInsets(top: dataSource.containsPending() ? 10: 0, left: 0, bottom: 10, right: 0)
    case .completed:
      return UIEdgeInsets(top: 10, left: 0, bottom: dataSource.containsCompleted() ? 10: 0, right: 0)
    }
  }
}

// MARK: - UITableViewDelegate
extension TodosViewController {
  override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
    return action == #selector(delete(_:))
  }
  
  override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) { }
  
  override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
    return true
  }
}

// MARK: - Actions
private extension TodosViewController {
  func didSelectTodo(_ todo: Todo, from cell: TodosCell) {
    interactor?.updateTodo(todo)
  }
  
  func didInvokeTodoCreation(textField: UITextField) {
    guard let todoText = textField.text, !todoText.isEmpty else { return }
    textField.text = nil
    dataSource.preserveEnteredText(textField.text)
    interactor?.createTodo(with: todoText)
  }
  
  func didInvokeTodoDeletion(at indexPath: IndexPath) {
    guard let todo = dataSource.todo(at: indexPath) else {
      return
    }
    
    let confirmationAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
      self.interactor?.deleteTodo(todo)
    } // TODO: - Localize
    
    UIAlertController
      .generic(title: "Delete", message: "Are you sure you want delete \"\(todo.title)\"?", actions: [confirmationAction], cancelTitle: "Cancel") // TODO: - Localise
      .present(on: self)
  }
}

// MARK: - Private Methods
private extension TodosViewController {
  func setupView() {
    title = "todos_tab_bar_title".localized()
    tabBarItem.image = #imageLiteral(resourceName: "tab_bar_todos_icon")
    collectionView?.backgroundColor = .martianLightGray
    setupCollectionView()
  }
  
  func setupCollectionView() {
    collectionView?.alwaysBounceVertical = true
    collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    collectionView?.register(TodosCell.self)
    collectionView?.registerSupplementaryView(TodosInputHeader.self, kind: UICollectionElementKindSectionHeader)
    collectionView?.registerSupplementaryView(TodosSectionHeader.self, kind: UICollectionElementKindSectionHeader)
    if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.minimumInteritemSpacing = 2
      flowLayout.headerReferenceSize = CGSize(width: itemSize.width, height: 40)
    }
  }
  
  @objc func test() {
    
  }
}
