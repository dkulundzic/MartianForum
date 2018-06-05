//
//  AlbumHeaderCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class AlbumHeaderReusableView: UICollectionReusableView {
  typealias ViewModel = String
  private let titleLabel = UILabel.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AlbumHeaderReusableView {
  func update(_ viewModel: ViewModel) {
    titleLabel.text = viewModel
  }
}

private extension AlbumHeaderReusableView {
  func setupViews() {
    setupTitleLabel()
  }
  
  func setupTitleLabel() {
    addSubview(titleLabel)
    titleLabel.font = .preferredFont(forTextStyle: .headline)
    titleLabel.adjustsFontForContentSizeCategory = true
    titleLabel.textColor = .black
    titleLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(16)
      $0.bottom.equalToSuperview().inset(10)
    }
  }
}
