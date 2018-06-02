//
//  PostsTitleCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import SnapKit

class PostCell: UITableViewCell {
  typealias ViewModel = (author: String, title: String?)
  
  private let authorLabel = UILabel.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    super.setHighlighted(highlighted, animated: animated)
    contentView.backgroundColor = highlighted ? UIColor.lightGray.withAlphaComponent(0.5): .clear
  }
}

extension PostCell {
  func update(viewModel: ViewModel) {
    authorLabel.text = "posts_author_title_label_format".localized(viewModel.author)
    titleLabel.text = viewModel.title
  }
}

private extension PostCell {
  func setupViews() {
    selectionStyle = .none
    setupTitleLabel()
    setupAuthorLabel()
  }
  
  func setupAuthorLabel() {
    contentView.addSubview(authorLabel)
    authorLabel.textColor = .martianRed
    authorLabel.font = .preferredFont(forTextStyle: .caption1)
    authorLabel.adjustsFontForContentSizeCategory = true
    authorLabel.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview().inset(16)
      $0.top.equalTo(titleLabel.snp.bottom).offset(6)
      $0.trailing.greaterThanOrEqualToSuperview().inset(16)
    }
  }
  
  func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textColor = .martianDarkGray
    titleLabel.font = .preferredFont(forTextStyle: .title2)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.numberOfLines = 0
    titleLabel.setContentHuggingPriority(.init(249), for: .vertical)
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview().inset(16)
    }
  }
}
