//
//  PostDetailsViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol PostDetailsDisplayLogic: class {
  func displayComments(_ comments: [Comment])
  func displayError(title: String?, message: String?)
}

class PostDetailsViewController: UITableViewController {
  var interactor: PostDetailsBusinessLogic?
  var router: PostDetailsRoutingLogic?
  private let dataSource: PostDetailsDataSource
  
  init(post: PostUser, delegate: PostDetailsRouterDelegate?) {
    dataSource = PostDetailsDataSource(post: post)
    super.init(nibName: nil, bundle: nil)
    let interactor = PostDetailsInteractor()
    let presenter = PostDetailsPresenter()
    let router = PostDetailsRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()
    interactor.loadComments()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.numberOfRows(in: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let row = dataSource.section(at: indexPath.section)?.row(at: indexPath.row) else {
      return UITableViewCell()
    }
    
    switch row {
    case .title(let viewModel):
      let cell = tableView.dequeueReusableCell(PostDetailsTitleCell.self, at: indexPath)
      cell.update(viewModel)
      return cell
    case .comment(let viewModel):
      let cell = tableView.dequeueReusableCell(PostDetailsCommentCell.self, at: indexPath)
      cell.update(viewModel)
      return cell
    case .input:
      let cell = tableView.dequeueReusableCell(PostDetailsInputCell.self, at: indexPath)
      cell.textField.delegate = self
      return cell
    }
  }
}

// MARK: - Display Logic
extension PostDetailsViewController: PostDetailsDisplayLogic {
  func displayComments(_ comments: [Comment]) {
    dataSource.addComments(comments)
    tableView.reloadData()
  }
  
  func displayError(title: String?, message: String?) {
    let alert = UIAlertController.generic(title: title, message: message, preferredStyle: .alert)
    alert.present(on: self)
  }
}

// MARK: - UITextFieldDelegate
extension PostDetailsViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    router?.navigateToCommentCreation(post: dataSource.post.post, commentPostHandler: { [weak self] in
      self?.handleCommentPost(comment: $0)
    })
    return false
  }
}

// MARK: - Private Methods
private extension PostDetailsViewController {
  func setupView() {
    navigationItem.largeTitleDisplayMode = .never
    setupTableView()
  }
  
  func setupTableView() {
    tableView.alwaysBounceVertical = true
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    tableView.register(PostDetailsTitleCell.self)
    tableView.register(PostDetailsCommentCell.self)
    tableView.register(PostDetailsInputCell.self)
  }
  
  func handleCommentPost(comment: Comment) {
    
  }
}
