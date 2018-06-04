//
//  AlbumPhotoCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 04/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumPhotoCell: UICollectionViewCell {
  typealias ViewModel = (placeholder: UIImage?, thumbnailUrl: URL, imageUrl: URL)
  private let imageView = UIImageView.autolayoutView()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AlbumPhotoCell {
  func update(_ viewModel: ViewModel) {
    imageView.kf.setImage(with: viewModel.thumbnailUrl, placeholder: viewModel.placeholder, options: [.transition(.fade(0.2))])
    imageView.kf.setImage(with: viewModel.imageUrl, placeholder: viewModel.placeholder, options: [.transition(.fade(0.2))])
  }
}

private extension AlbumPhotoCell {
  func setupViews() {
    setupImageView()
  }
  
  func setupImageView() {
    contentView.addSubview(imageView)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
