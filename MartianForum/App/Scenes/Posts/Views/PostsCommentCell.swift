//
//  PostsCommentCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PostsCommentCell: UITableViewCell {
  typealias ViewModel = (String, String)
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }  
}

extension PostsCommentCell {
  func update(viewModel: ViewModel) {
    
  }
}

private extension PostsCommentCell {
  func setupViews() {
    
  }
}
