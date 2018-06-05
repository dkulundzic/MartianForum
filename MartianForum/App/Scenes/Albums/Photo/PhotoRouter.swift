//
//  PhotoRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 05/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PhotoRoutingLogic {
  func unwindBack()
}

protocol PhotoRouterDelegate: class {
  func photoRouterDelegateUnwindBack()
}

class PhotoRouter {
  weak var viewController: PhotoViewController?
  weak var delegate: PhotoRouterDelegate?
}

// MARK: - Routing Logic
extension PhotoRouter: PhotoRoutingLogic {
  func unwindBack() {
    delegate?.photoRouterDelegateUnwindBack()
  }
}
