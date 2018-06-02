//
//  PostsContentView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PostsContentView: UIView {
  let tableView = UITableView.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods
private extension PostsContentView {
  func setupView() {
    setupTableView()
  }
  
  func setupTableView() {
    addSubview(tableView)
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.alwaysBounceVertical = true
    tableView.estimatedRowHeight = 100
    tableView.register(PostCell.self)
    tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
  }
}
