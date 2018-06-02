//
//  CommentingContentView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class CommentingContentView: UIView {
  let textView = UITextView.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Methods
private extension CommentingContentView {
  func setupView() {
    setupTitleLabel()
    setupTextView()
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.textColor = .martianDarkGray
    titleLabel.font = .preferredFont(forTextStyle: .title1)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.numberOfLines = 0
    titleLabel.setContentHuggingPriority(.init(249), for: .vertical)
    titleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  func setupTextView() {
    addSubview(textView)
    textView.textContainerInset = .zero
    textView.textColor = .martianGray
    textView.font = .preferredFont(forTextStyle: .body)
    textView.adjustsFontForContentSizeCategory = true
    textView.snp.makeConstraints {
      $0.bottom.leading.trailing.equalToSuperview().inset(16)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
  }
}
