//
//  TabBarController.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  init() {
    super.init(nibName: nil, bundle: nil)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension TabBarController {
  func setupView() {
    setupTabs()
  }
  
  func setupTabs() {
    
  }
}