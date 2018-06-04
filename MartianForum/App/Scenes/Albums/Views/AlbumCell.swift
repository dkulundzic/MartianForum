//
//  AlbumCell.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
  override func prepareForReuse() {
    super.prepareForReuse()
    contentView.subviews.forEach { $0.removeFromSuperview() }
  }
  
  func constrain(viewController: PhotosViewController) {
    contentView.addSubview(viewController.view)
    viewController.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
