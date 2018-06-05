//
//  PhotoContentView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Kingfisher

class PhotoContentView: UIView {
  typealias ViewModel = Photo
  private let imageView = UIImageView.autolayoutView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PhotoContentView {
  func update(_ viewModel: Photo) {
    imageView.kf.setImage(with: ImageResource(downloadURL: viewModel.url))
  }
}
  
// MARK: - Private Methods
private extension PhotoContentView {
  func setupView() {
    setupImageView()
  }
  
  func setupImageView() {
    addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.kf.indicatorType = .activity
    imageView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.edges.greaterThanOrEqualToSuperview()
    }
  }
}
