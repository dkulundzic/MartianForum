//
//  PostDetailsTitleCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class PostDetailsTitleCell: UITableViewCell {
  typealias ViewModel = (author: String, title: String?, body: String?)
  
  private let authorLabel = UILabel.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  private let bodyLabel = UILabel.autolayoutView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PostDetailsTitleCell {
  func update(_ viewModel: ViewModel) {
    authorLabel.text = viewModel.author
    titleLabel.text = viewModel.title
    bodyLabel.text = viewModel.body
  }
}

private extension PostDetailsTitleCell {
  func setupViews() {
    selectionStyle = .none
    contentView.backgroundColor = .martianLightGray
    setupAuthorLabel()
    setupTitleLabel()
    setupBodyLabel()
  }
  
  func setupAuthorLabel() {
    contentView.addSubview(authorLabel)
    authorLabel.textColor = .martianRed
    authorLabel.font = .preferredFont(forTextStyle: .caption2)
    authorLabel.adjustsFontForContentSizeCategory = true
    authorLabel.snp.makeConstraints {
      $0.leading.top.equalToSuperview().inset(16)
      $0.trailing.greaterThanOrEqualToSuperview().inset(16)
    }
  }
  
  func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textColor = .martianDarkGray
    titleLabel.font = .preferredFont(forTextStyle: .title1)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.numberOfLines = 0
    titleLabel.setContentHuggingPriority(.init(249), for: .vertical)
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.top.equalTo(authorLabel.snp.bottom).offset(2)
    }
  }
  
  func setupBodyLabel() {
    contentView.addSubview(bodyLabel)
    bodyLabel.textColor = .martianDarkGray
    bodyLabel.font = .preferredFont(forTextStyle: .body)
    bodyLabel.adjustsFontForContentSizeCategory = true
    bodyLabel.numberOfLines = 0
    bodyLabel.setContentHuggingPriority(.init(248), for: .vertical)
    bodyLabel.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview().inset(16)
      $0.top.equalTo(titleLabel.snp.bottom).offset(6)
    }
  }
}
