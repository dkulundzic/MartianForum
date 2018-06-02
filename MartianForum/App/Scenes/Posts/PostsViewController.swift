//
//  PostsViewController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol PostsDisplayLogic: class {
  func displayPosts(_ posts: [PostUser])
  func displayNetworkOperation(running: Bool)
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
  func displayPosts(_ posts: [PostUser]) {
    contentView.tableView.refreshControl?.endRefreshing()
    dataSource.addPosts(posts)
    contentView.tableView.reloadData()
  }
  
  func displayNetworkOperation(running: Bool) {
    guard !(contentView.tableView.refreshControl?.isRefreshing ?? true) else { return }
    let barButton = running ? UIBarButtonItem.loadingIndicator(): nil
    navigationItem.setRightBarButton(barButton, animated: true)
  }
  
  func displayError(title: String?, message: String?) {
    contentView.tableView.refreshControl?.endRefreshing()
    let alert = UIAlertController.generic(title: title, message: message, preferredStyle: .alert)
    alert.present(on: self)
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

// MARK: - Actions
private extension PostsViewController {
  @objc func refreshControlEngaged(_ sender: UIRefreshControl) {
    interactor?.loadPosts()
  }
}

// MARK: - Private Methods
private extension PostsViewController {
  func setupView() {
    title = "posts_tab_bar_title".localized()
    tabBarItem.image = #imageLiteral(resourceName: "tab_bar_posts_icon")
    view.backgroundColor = .white
    setupContentView()
  }
  
  func setupContentView() {
    view.addSubview(contentView)
    contentView.tableView.dataSource = self
    contentView.tableView.delegate = self
    contentView.tableView.refreshControl = UIRefreshControl(frame: .zero)
    contentView.tableView.refreshControl?.addTarget(self, action: #selector(refreshControlEngaged(_:)), for: .valueChanged)
    contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
