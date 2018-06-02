//
//  PostsTitleCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import SnapKit

class PostCell: UITableViewCell {
  typealias ViewModel = (title: String?, body: String?)
  
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

extension PostCell {
  func update(viewModel: ViewModel) {
    titleLabel.text = viewModel.title
    bodyLabel.text = viewModel.body
  }
}

private extension PostCell {
  func setupViews() {
    selectionStyle = .none
    setupTitleLabel()
    setupBodyLabel()
  }
  
  func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.textColor = .black
    titleLabel.font = .preferredFont(forTextStyle: .title2)
    titleLabel.numberOfLines = 0
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.top.equalToSuperview().inset(16)
    }
  }
  
  func setupBodyLabel() {
    contentView.addSubview(bodyLabel)
    bodyLabel.textColor = .martianGray
    bodyLabel.font = .preferredFont(forTextStyle: .body)
    bodyLabel.numberOfLines = 0
    bodyLabel.setContentHuggingPriority(.init(249), for: .vertical)
    bodyLabel.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview().inset(16)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
  }
}
