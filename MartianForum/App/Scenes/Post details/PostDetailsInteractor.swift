//
//  PostDetailsInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 02/06/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostDetailsBusinessLogic {
  func loadComments()
}

class PostDetailsInteractor {
  var presenter: PostDetailsPresentationLogic?
  lazy var commentsWorker = CommentsWorker()
}

// MARK: - Business Logic
extension PostDetailsInteractor: PostDetailsBusinessLogic {
  func loadComments() {
    commentsWorker.getComments().then { [weak self] in
      self?.presenter?.presentComments($0)
    }.catch { [weak self] in
      self?.presenter?.presentError(NetworkError.wrapped($0))
    }
  }
}
