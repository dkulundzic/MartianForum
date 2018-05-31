//
//  PostsTitleCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
  typealias ViewModel = (String, String)
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PostCell {
  func update(viewModel: ViewModel) {
    // TODO: -
  }
}

private extension PostCell {
  func setupViews() {
    // TODO: - 
  }
}
