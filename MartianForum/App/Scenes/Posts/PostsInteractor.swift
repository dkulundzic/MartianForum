//
//  PostsInteractor.swift
//  MartianForum
//
//  Created by Domagoj Kulundzic on 28/05/2018.
//  Copyright © 2018 Codeopolis. All rights reserved.
//

import Foundation

protocol PostsBusinessLogic {
  func loadPosts()
}

class PostsInteractor {
  var presenter: PostsPresentationLogic?
  lazy var postsWorker = PostsWorker()
}

// MARK: - Business Logic
extension PostsInteractor: PostsBusinessLogic {
  func loadPosts() {
    presenter?.presentNetworkOperation(running: true)
    postsWorker.getPosts().then { [weak self] in
      self?.presenter?.presentPosts($0)
    }.always { [weak self] in
      self?.presenter?.presentNetworkOperation(running: false)
    }.catch { [weak self] in
      self?.presenter?.presentError(NetworkError.wrapped($0))
    }
  }
}
