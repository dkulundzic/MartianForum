//
//  PostsRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostsRoutingLogic {
  func navigateToPostDetails(_ post: PostUser)
}

protocol PostsRouterDelegate: class {
  
}

class PostsRouter {
  weak var viewController: PostsViewController?
  weak var delegate: PostsRouterDelegate?
}

// MARK: - Routing Logic
extension PostsRouter: PostsRoutingLogic {
  func navigateToPostDetails(_ post: PostUser) {
    let postDetailsViewController = PostDetailsViewController(post: post, delegate: self)
    viewController?.navigationController?.pushViewController(postDetailsViewController, animated: true)
  }
}

// MARK: - PostDetailsRouterDelegate
extension PostsRouter: PostDetailsRouterDelegate {
  
}
