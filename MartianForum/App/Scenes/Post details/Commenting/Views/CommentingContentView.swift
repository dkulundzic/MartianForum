//
//  CommentingContentView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class CommentingContentView: UIView {
  typealias ViewModel = String
  
  let textView = UITextView.autolayoutView()
  private let titleLabel = UILabel.autolayoutView()
  private let titleContainerView = UIView.autolayoutView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CommentingContentView {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel
  }
}

// MARK: - Private Methods
private extension CommentingContentView {
  func setupView() {
    setupTitleContainerView()
    setupTitleLabel()
    setupTextView()
  }
  
  func setupTitleContainerView() {
    addSubview(titleContainerView)
    titleContainerView.backgroundColor = .martianLightGray
    titleContainerView.layer.cornerRadius = 10
    titleContainerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    titleContainerView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
  }
  
  func setupTitleLabel() {
    titleContainerView.addSubview(titleLabel)
    titleLabel.textColor = .martianDarkGray
    titleLabel.font = .preferredFont(forTextStyle: .title3)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.numberOfLines = 0
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(5)
      $0.leading.trailing.equalToSuperview().inset(16)
    }
  }
  
  func setupTextView() {
    addSubview(textView)
    textView.textContainerInset = .zero
    textView.textColor = .martianGray
    textView.font = .preferredFont(forTextStyle: .body)
    textView.adjustsFontForContentSizeCategory = true
    textView.setContentHuggingPriority(.init(249), for: .vertical)
    textView.snp.makeConstraints {
      $0.bottom.leading.trailing.equalToSuperview().inset(16)
      $0.top.equalTo(titleContainerView.snp.bottom).offset(5)
    }
  }
}
