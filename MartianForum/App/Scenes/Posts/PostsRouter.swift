//
//  PostsRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostsRoutingLogic {
  
}

protocol PostsRouterDelegate: class {
  
}

class PostsRouter {
  weak var viewController: PostsViewController?
  weak var delegate: PostsRouterDelegate?
}

// MARK: - Routing Logic
extension PostsRouter: PostsRoutingLogic {
  
}
