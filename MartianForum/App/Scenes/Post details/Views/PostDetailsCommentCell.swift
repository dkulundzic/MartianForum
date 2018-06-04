//
//  PostDetailsCommentCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PostDetailsCommentCell: UITableViewCell {
  typealias ViewModel = (author: String, body: String)
  
  private let authorLabel = UILabel.autolayoutView()
  private let bodyLabel = UILabel.autolayoutView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PostDetailsCommentCell {
  func update(_ viewModel: ViewModel) {
    authorLabel.text = viewModel.author
    bodyLabel.text = viewModel.body
  }
}

private extension PostDetailsCommentCell {
  func setupViews() {
    selectionStyle = .none
    setupAuthorLabel()
    setupBodyLabel()
  }
  
  func setupAuthorLabel() {
    contentView.addSubview(authorLabel)
    authorLabel.textColor = .martianRed
    authorLabel.font = .preferredFont(forTextStyle: .caption1)
    authorLabel.numberOfLines = 0
    authorLabel.adjustsFontForContentSizeCategory = true
    authorLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(32)
      $0.top.trailing.equalToSuperview().inset(16)
    }
  }
  
  func setupBodyLabel() {
    contentView.addSubview(bodyLabel)
    bodyLabel.textColor = .martianDarkGray
    bodyLabel.font = .preferredFont(forTextStyle: .body)
    bodyLabel.adjustsFontForContentSizeCategory = true
    bodyLabel.numberOfLines = 0
    bodyLabel.setContentHuggingPriority(.init(249), for: .vertical)
    bodyLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(32)
      $0.trailing.bottom.equalToSuperview().inset(16)
      $0.top.equalTo(authorLabel.snp.bottom).offset(6)
    }
  }
}
