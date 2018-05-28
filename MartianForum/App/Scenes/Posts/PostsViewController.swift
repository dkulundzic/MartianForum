//
//  PostsViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol PostsDisplayLogic: class {
  
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
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Display Logic
extension PostsViewController: PostsDisplayLogic {
  
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
    case .title:
      return UITableViewCell()
    case .comment:
      return UITableViewCell()
    }
  }
}

// MARK: - UITableViewDelegate
extension PostsViewController: UITableViewDelegate {
  
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
  }
}
