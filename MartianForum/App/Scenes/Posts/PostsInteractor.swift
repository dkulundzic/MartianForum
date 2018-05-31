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
    postsWorker.getPosts(success: { [weak self] posts in
      self?.presenter?.presentPosts(posts)
    }, failure: { [weak self] error in
      self?.presenter?.presentError(NetworkError.wrapped(error))
    })
  }
}
