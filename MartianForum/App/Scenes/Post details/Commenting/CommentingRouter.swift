//
//  CommentingRouter.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol CommentingRoutingLogic {
  func unwindBack()
}

protocol CommentingRouterDelegate: class {
  func commentingRouterUnwindBack()
}

class CommentingRouter {
  weak var viewController: CommentingViewController?
  weak var delegate: CommentingRouterDelegate?
}

// MARK: - Routing Logic
extension CommentingRouter: CommentingRoutingLogic {
  func unwindBack() {
    delegate?.commentingRouterUnwindBack()
  }
}
