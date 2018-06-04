//
//  AlbumsContentView.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class AlbumsContentView: UIView {
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension AlbumsContentView {
  func setupViews() {
    setupScrollView()
    setupStackView()
  }
  
  func setupScrollView() {
    
  }
  
  func setupStackView() {
    
  }
}
