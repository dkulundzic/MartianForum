//
//  AlbumsRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol AlbumsRoutingLogic {
  
}

protocol AlbumsRouterDelegate: class {
  
}

class AlbumsRouter {
  weak var viewController: AlbumsViewController?
  weak var delegate: AlbumsRouterDelegate?
}

// MARK: - Routing Logic
extension AlbumsRouter: AlbumsRoutingLogic {
  
}
