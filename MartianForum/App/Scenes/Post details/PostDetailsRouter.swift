//
//  PostDetailsRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import UIKit

protocol PostDetailsRoutingLogic {
  func navigateToCommentCreation(post: Post, commentPostHandler: ((Comment) -> Void)?)
}

protocol PostDetailsRouterDelegate: class {
  
}

class PostDetailsRouter {
  weak var viewController: PostDetailsViewController?
  weak var delegate: PostDetailsRouterDelegate?
}

// MARK: - Routing Logic
extension PostDetailsRouter: PostDetailsRoutingLogic {
  func navigateToCommentCreation(post: Post, commentPostHandler: ((Comment) -> Void)?) {
    let commentingViewController = CommentingViewController(post: post, handler: commentPostHandler, delegate: self)
    viewController?.present(UINavigationController(rootViewController: commentingViewController), animated: true, completion: nil)
  }
}

// MARK: - CommentingRouterDelegate
extension PostDetailsRouter: CommentingRouterDelegate {
  func commentingRouterUnwindBack() {
    viewController?.dismiss(animated: true, completion: nil)
  }
}
