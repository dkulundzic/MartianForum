//
//  AlbumsContentView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class AlbumsContentView: UIView {  
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
private extension AlbumsContentView {
  func setupView() {
    // TODO: - 
  }
}
