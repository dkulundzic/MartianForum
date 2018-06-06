//
//  TodosSectionHeader.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 06/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class TodosSectionHeader: UICollectionReusableView {
  struct ViewModel {
    let title: String
  }
  
  private let titleLabel = UILabel.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TodosSectionHeader {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel.title
  }
}

private extension TodosSectionHeader {
  func setupViews() {
    backgroundColor = .white
    layer.cornerRadius = 2
    setupTitleLabel()
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = .preferredFont(forTextStyle: .caption1)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.textColor = .black
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.centerY.equalToSuperview()
    }
  }
}
