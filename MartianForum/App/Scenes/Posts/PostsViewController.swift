//
//  PostsViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol PostsDisplayLogic: class {
  func displayPosts(_ posts: [Post])
  func displayError(title: String?, message: String?)
}

class PostsViewController: UIViewController {
  var interactor: PostsBusinessLogic?
  var router: PostsRoutingLogic?
  private let contentView = PostsContentView.autolayoutView()
  private let dataSource = PostsDataSource()
  
  init(delegate: PostsRouterDelegate?) {
    super.init(nibName: nil, bundle: nil)
    let interactor = PostsInteractor()
    let presenter = PostsPresenter()
    let router = PostsRouter()
    interactor.presenter = presenter
    presenter.viewController = self
    router.viewController = self
    router.delegate = delegate
    self.interactor = interactor
    self.router = router
    setupView()
    interactor.loadPosts()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Display Logic
extension PostsViewController: PostsDisplayLogic {
  func displayPosts(_ posts: [Post]) {
    dataSource.addPosts(posts)
    contentView.tableView.reloadData()
  }
  
  func displayError(title: String?, message: String?) {
    // TODO: - 
  }
}

// MARK: - UITableViewDataSource
extension PostsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.section(at: section)?.rows.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let row = dataSource.section(at: indexPath.section)?.row(at: indexPath.row) else {
      return UITableViewCell()
    }
    
    switch row {
    case .post(let viewModel, _):
      let cell = tableView.dequeueReusableCell(PostCell.self, at: indexPath)
      cell.update(viewModel: viewModel)
      return cell
    }
  }
}

// MARK: - UITableViewDelegate
extension PostsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let row = dataSource.section(at: indexPath.section)?.row(at: indexPath.row) else {
      return
    }
    
    switch row {
    case .post(_, let post):
      router?.navigateToPostDetails(post)
    }
  }
}

// MARK: - Private Methods
private extension PostsViewController {
  func setupView() {
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.tableView.dataSource = self
    contentView.tableView.delegate = self
    contentView.tableView.register(PostCell.self)
  }
}
